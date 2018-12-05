require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_activities' do
  include_context 'API client'
  describe '#athlete_activities' do
    it 'returns athlete activities', vcr: { cassette_name: 'client/athlete_activities' } do
      athlete_activities = client.athlete_activities
      expect(athlete_activities).to be_a Enumerable
      expect(athlete_activities.count).to eq 30
      activity = athlete_activities.first
      expect(activity.id).to eq 1_972_463_847
      expect(activity.athlete).to be_a Strava::Models::Athlete
      expect(activity.map).to be_a Strava::Models::Map
      expect(activity.start_date).to be_a Time
    end
    it 'returns athlete activities for December 2018 only', vcr: { cassette_name: 'client/athlete_activities_december_2018' } do
      athlete_activities = client.athlete_activities(before: Time.parse('2019/1/1'), after: Time.parse('2018/11/1'))
      expect(athlete_activities).to be_a Enumerable
      expect(athlete_activities.count).to eq 8
    end
  end
  describe 'paginated #athlete_activities', vcr: { cassette_name: 'client/all_athlete_activities' } do
    let(:athlete_activities) do
      all = []
      client.athlete_activities do |activity|
        all << activity
      end
      all
    end
    it 'returns athlete activities' do
      expect(athlete_activities).to be_a Enumerable
      expect(athlete_activities.count).to eq 40
      expect(athlete_activities.all? { |a| a.athlete.is_a?(Strava::Models::Athlete) }).to be true
      expect(athlete_activities.map(&:id).uniq.count).to eq athlete_activities.count
    end
  end
  describe 'paginated #athlete_activities by 72', vcr: { cassette_name: 'client/all_athlete_activities_by_72' } do
    let(:athlete_activities) do
      all = []
      client.athlete_activities(per_page: 72) do |activity|
        all << activity
      end
      all
    end
    it 'returns athlete activities' do
      expect(athlete_activities).to be_a Enumerable
      expect(athlete_activities.count).to eq 130
      expect(athlete_activities.map(&:id).uniq.count).to eq athlete_activities.count
    end
  end
end

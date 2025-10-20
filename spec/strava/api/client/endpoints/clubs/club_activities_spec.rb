# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_activities' do
  include_context 'with API client'
  describe '#club_activities', vcr: { cassette_name: 'client/club_activities' } do
    it 'returns club activities' do
      club_activities = client.club_activities(id: 209_437)
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 30
      activity = club_activities.first
      expect(activity).to be_a Strava::Models::ClubActivity
      expect(activity.distance).to eq 10_399.9
      expect(activity.name).to eq 'Run for The Nature Conservancy'
    end

    it 'returns club activities by id' do
      club_activities = client.club_activities(209_437)
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 30
    end
  end

  describe 'paginated #club_activities', vcr: { cassette_name: 'client/all_club_activities' } do
    let(:club_activities) do
      all = []
      client.club_activities(id: 209_437) do |activity|
        all << activity
      end
      all
    end

    it 'returns club activities' do
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 96
    end
  end
end

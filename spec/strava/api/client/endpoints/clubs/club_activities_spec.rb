require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_activities' do
  include_context 'API client'
  describe '#club_activities', vcr: { cassette_name: 'client/club_activities' } do
    it 'returns club activities' do
      club_activities = client.club_activities(id: 108_605)
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 23
      activity = club_activities.first
      expect(activity.distance).to eq 7004.3
      expect(activity.name).to eq 'Run for Stand Up To Cancer'
    end
    it 'returns club activities by id' do
      club_activities = client.club_activities(108_605)
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 23
    end
  end
  describe 'paginated #club_activities', vcr: { cassette_name: 'client/all_club_activities' } do
    let(:club_activities) do
      all = []
      client.club_activities(id: 108_605) do |activity|
        all << activity
      end
      all
    end
    it 'returns club activities' do
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 153
    end
  end
end

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_activities' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  describe '#club_activities', vcr: { cassette_name: 'client/club_activities' } do
    let(:club_activities) { client.club_activities(id: 108_605) }
    it 'returns club activities' do
      expect(club_activities).to be_a Enumerable
      expect(club_activities.count).to eq 23
      activity = club_activities.first
      expect(activity.distance).to eq 7004.3
      expect(activity.name).to eq 'Run for Stand Up To Cancer'
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

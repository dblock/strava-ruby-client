require 'spec_helper'

RSpec.describe 'Strava::Api::Client#update_activity' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  describe '#athlete_activities', vcr: { cassette_name: 'client/update_activity' } do
    let(:activity) do
      client.update_activity(
        id: 1_982_980_795,
        name: 'updated activity',
        description: 'Updated test strava-ruby-client activity.'
      )
    end
    it 'updates the activity' do
      expect(activity).to be_a Strava::Models::Activity
      expect(activity.name).to eq 'updated activity'
      expect(activity.description).to eq 'Updated test strava-ruby-client activity.'
    end
  end
end

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_events', vcr: { cassette_name: 'client/club_events' } do
  include_context 'API client'
  it 'returns club events' do
    club_events = client.club_events('456773')
    expect(club_events).to be_a Enumerable
    event = club_events.first
    expect(event).to be_a Strava::Models::ClubEvent
  end
end

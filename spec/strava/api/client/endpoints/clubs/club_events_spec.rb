require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_events', vcr: { cassette_name: 'client/club_events' } do
  include_context 'API client'
  it 'returns club events' do
    club_events = client.club_events('456773')
    expect(club_events.size).to eq 107
    expect(club_events).to be_a Enumerable
    event = club_events.first
    expect(event.women_only).to be_a FalseClass
    expect(event.private).to be_a FalseClass
    expect(event.resource_state).to be_a Integer
    expect(event.club_id).to be_a Integer
    expect(event.skill_levels).to be_a Integer
    expect(event.terrain).to be_a Integer
    expect(event.route_id).to be_a_kind_of(Integer).or(be_nil)
    expect(event.upcoming_occurrences).to be_a Enumerable
    expect(event.upcoming_occurrences.first).to be_a Time
    expect(event).to be_a Strava::Models::ClubEvent
  end
end

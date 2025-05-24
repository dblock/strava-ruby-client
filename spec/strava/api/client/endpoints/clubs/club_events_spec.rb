# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_events', vcr: { cassette_name: 'client/club_events' } do
  include_context 'with API client'
  it 'returns club events' do
    club_events = client.club_events('456773')
    expect(club_events).to be_a Enumerable
    expect(club_events.size).to eq 107
    event = club_events.find { |e| e.id == 340_487 }
    expect(event.id).to be_a Integer
    expect(event.id).to eq(340_487)
    expect(event.women_only).to be_a FalseClass
    expect(event.private).to be_a FalseClass
    expect(event.description).to be_a String
    expect(event.description.size).to eq(546)
    expect(event.description).to start_with('Damit die Fahrt stattfindet wird')
    expect(event.resource_state).to be_a Integer
    expect(event.resource_state).to eq(2)
    expect(event.club_id).to be_a Integer
    expect(event.club_id).to eq(456_773)
    expect(event.skill_levels).to be_a Integer
    expect(event.skill_levels).to eq(1)
    expect(event.terrain).to be_a Integer
    expect(event.route_id).to be_a(Integer).or(be_nil)
    expect(event.upcoming_occurrences).to be_a Enumerable
    expect(event.upcoming_occurrences.first).to be_a Time
    expect(event.upcoming_occurrences.first).to eq(Time.new(2018, 6, 23, 8, 30, 0, '+00:00'))
    expect(event).to be_a Strava::Models::ClubEvent
  end

  context 'when created_at is invalid' do
    let(:invalid_event_json) do
      {
        'id' => 123,
        'resource_state' => 2,
        'title' => 'Invalid Event',
        'club_id' => 456,
        'organizing_athlete' => { 'id' => 789, 'firstname' => 'John', 'lastname' => 'Doe' },
        'activity_type' => 'Ride',
        'created_at' => 'invalid-date',
        'route_id' => nil,
        'route' => nil
      }
    end

    it 'returns club events without created_at value' do
      event = Strava::Models::ClubEvent.new(invalid_event_json)
      expect(event.created_at).to be_nil
      expect(event.strava_url).to eq 'https://www.strava.com/clubs/456/group_events/123'
      expect(event.organizing_athlete).to be_a Strava::Models::Athlete
      expect(event.route).to be_nil
    end
  end
end

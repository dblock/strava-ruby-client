# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#route', vcr: { cassette_name: 'client/route' } do
  include_context 'with API client'
  it 'returns a route' do
    route = client.route(id: 16_341_573)
    expect(route).to be_a Strava::Models::Route
    expect(route.id).to eq 16_341_573
    expect(route.athlete).to be_a Strava::Models::SummaryAthlete
    expect(route.name).to eq 'Lower Manhattan Loop'
    expect(route.description).to eq 'My usual long run when I am too lazy to go to Central Park.'
    expect(route.elevation_gain).to eq 117.25346822039764
    expect(route.elevation_gain_s).to eq '117.3m'
    expect(route.map).to be_a Strava::Models::Map
    expect(route.private).to be false
    expect(route.resource_state).to eq 3
    expect(route.starred).to be false
    expect(route.sub_type).to eq 1
    expect(route.timestamp).to be_a Time
    expect(route.created_at).to be_a Time
    expect(route.updated_at).to be_a Time
    expect(route.type).to eq 2
    expect(route.estimated_moving_time).to eq 5282
    expect(route.estimated_moving_time_in_hours_s).to eq '1h28m2s'
    expect(route.segments).to be_a Enumerable
    segment = route.segments.first
    expect(segment).to be_a Strava::Models::SummarySegment
    expect(segment.id).to eq 1_040_724
    expect(segment.resource_state).to eq 2
    expect(segment.name).to eq 'Esplanade Climb'
    expect(segment.maximum_grade).to eq(2.0)
    expect(segment.elevation_high).to eq 0.3
    expect(segment.elevation_low).to eq 0.1
    expect(segment.activity_type).to eq 'Run'
    expect(segment.average_grade).to eq(-0.0)
    expect(segment.climb_category).to eq 0
    expect(segment.city).to eq 'New York'
    expect(segment.state).to eq 'NY'
    expect(segment.country).to eq 'United States'
    expect(segment.start_latlng).to eq [40.7119844, -74.017878]
    expect(segment.end_latlng).to eq [40.7137168, -74.0176807]
    expect(segment.private).to be false
    expect(segment.hazardous).to be false
    expect(segment.starred).to be false
  end

  it 'returns a route by id' do
    route = client.route(16_341_573)
    expect(route).to be_a Strava::Models::Route
  end
end

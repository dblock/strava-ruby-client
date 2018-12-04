require 'spec_helper'

RSpec.describe 'Strava::Api::Client#route', vcr: { cassette_name: 'client/route' } do
  include_context 'API client'
  it 'returns a route' do
    route = client.route(id: 16_341_573)
    expect(route).to be_a Strava::Models::Route
    expect(route.id).to eq 16_341_573
    expect(route.athlete).to be_a Strava::Models::Athlete
    expect(route.name).to eq 'Lower Manhattan Loop'
    expect(route.description).to eq 'My usual long run when I am too lazy to go to Central Park.'
    expect(route.total_elevation_gain).to eq 117.25346822039764
    expect(route.total_elevation_gain_s).to eq '117.3m'
    expect(route.map).to be_a Strava::Models::Map
    expect(route.private).to be false
    expect(route.resource_state).to eq 3
    expect(route.starred).to be false
    expect(route.sub_type).to eq 1
    expect(route.timestamp).to be_a Time
    expect(route.created_at).to be_a Time
    expect(route.updated_at).to be_a Time
    expect(route.type).to eq 2
    expect(route.estimated_moving_time).to eq 4885
    expect(route.moving_time).to eq 4885
    expect(route.moving_time_in_hours_s).to eq '1h21m25s'
    expect(route.segments).to be_a Enumerable
    segment = route.segments.first
    expect(segment).to be_a Strava::Models::Segment
    expect(segment.id).to eq 1_109_718
    expect(segment.resource_state).to eq 2
    expect(segment.name).to eq 'E 14th St Climb'
    expect(segment.maximum_grade).to eq(-0.6)
    expect(segment.elevation_high).to eq 7.1
    expect(segment.elevation_low).to eq 3.8
    expect(segment.activity_type).to eq 'Run'
    expect(segment.average_grade).to eq(-0.8)
    expect(segment.climb_category).to eq 0
    expect(segment.city).to eq 'New York'
    expect(segment.state).to eq 'NY'
    expect(segment.country).to eq 'United States'
    expect(segment.start_latlng).to eq [40.73554842732847, -73.98271151818335]
    expect(segment.end_latlng).to eq [40.73427177965641, -73.97865023463964]
    expect(segment.start_latitude).to eq 40.73554842732847
    expect(segment.start_longitude).to eq(-73.98271151818335)
    expect(segment.end_latitude).to eq 40.73427177965641
    expect(segment.end_longitude).to eq(-73.97865023463964)
    expect(segment.private).to eq false
    expect(segment.hazardous).to eq false
    expect(segment.starred).to eq false
  end
  it 'returns a route by id' do
    route = client.route(16_341_573)
    expect(route).to be_a Strava::Models::Route
  end
end

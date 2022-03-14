# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_routes', vcr: { cassette_name: 'client/athlete_routes' } do
  include_context 'API client'
  it 'returns routes' do
    routes = client.athlete_routes(id: 26_462_176)
    expect(routes).to be_a Enumerable
    route = routes.first
    expect(route).to be_a Strava::Models::Route
    expect(route.id).to eq 16_341_573
    expect(route.athlete).to be_a Strava::Models::Athlete
    expect(route.name).to eq 'Lower Manhattan Loop'
    expect(route.description).to eq 'My usual long run when I am too lazy to go to Central Park.'
    expect(route.total_elevation_gain).to eq 117.25346822039764
    expect(route.total_elevation_gain_s).to eq '117.3m'
    expect(route.map).to be_a Strava::Models::Map
    expect(route.private).to be false
    expect(route.resource_state).to eq 2
    expect(route.starred).to be false
    expect(route.sub_type).to eq 1
    expect(route.timestamp).to be_a Time
    expect(route.created_at).to be_a Time
    expect(route.updated_at).to be_a Time
    expect(route.type).to eq 2
    expect(route.estimated_moving_time).to eq 4865
    expect(route.moving_time).to eq 4865
    expect(route.moving_time_in_hours_s).to eq '1h21m5s'
  end
  it 'returns routes by id' do
    routes = client.athlete_routes(26_462_176)
    expect(routes).to be_a Enumerable
    route = routes.first
    expect(route).to be_a Strava::Models::Route
  end
end

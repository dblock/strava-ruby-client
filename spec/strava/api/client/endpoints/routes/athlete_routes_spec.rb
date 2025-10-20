# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_routes', vcr: { cassette_name: 'client/athlete_routes' } do
  include_context 'with API client'

  it 'returns routes' do
    routes = client.athlete_routes(id: 26_462_176)
    expect(routes).to be_a Enumerable
    route = routes.first
    expect(route).to be_a Strava::Models::Route
    expect(route.id).to eq 3_329_485_690_369_457_990
    expect(route.athlete).to be_a Strava::Models::SummaryAthlete
    expect(route.athlete.strava_url).to eq 'https://www.strava.com/athletes/26462176'
    expect(route.name).to eq 'Little Island'
    expect(route.description).to be_nil
    expect(route.elevation_gain).to eq 19.770000000000003
    expect(route.elevation_gain_s).to eq '19.8m'
    expect(route.map).to be_a Strava::Models::Map
    expect(route.private).to be true
    expect(route.resource_state).to eq 2
    expect(route.starred).to be true
    expect(route.sub_type).to eq 1
    expect(route.timestamp).to be_a Time
    expect(route.created_at).to be_a Time
    expect(route.updated_at).to be_a Time
    expect(route.type).to eq 2
    expect(route.estimated_moving_time).to eq 2021
    expect(route.estimated_moving_time_in_hours_s).to eq '33m41s'
  end

  it 'returns routes by id' do
    routes = client.athlete_routes(26_462_176)
    expect(routes).to be_a Enumerable
    route = routes.first
    expect(route).to be_a Strava::Models::Route
  end
end

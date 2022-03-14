# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#running_race', vcr: { cassette_name: 'client/running_race' } do
  include_context 'API client'
  it 'returns a running race' do
    running_race = client.running_race(id: 1577)
    expect(running_race).to be_a Strava::Models::RunningRace
    expect(running_race.id).to eq 1577
    expect(running_race.resource_state).to eq 3
    expect(running_race.status).to eq 1
    expect(running_race.name).to eq 'Walt Disney World Marathon 10k'
    expect(running_race.running_race_type).to eq 0
    expect(running_race.distance).to eq 10_000.0
    expect(running_race.distance_s).to eq '10km'
    expect(running_race.start_date_local).to be_a Time
    expect(running_race.city).to eq 'Orlando'
    expect(running_race.state).to eq 'FL'
    expect(running_race.country).to eq 'United States'
    expect(running_race.route_ids).to eq [11_426_012]
    expect(running_race.measurement_preference).to eq 'meters'
    expect(running_race.url).to eq '2018-walt-disney-world-marathon-10k'
    expect(running_race.strava_url).to eq 'https://www.strava.com/running-races/2018-walt-disney-world-marathon-10k'
    expect(running_race.website_url).to eq 'https://www.rundisney.com/disneyworld-marathon/'
  end
  it 'returns a running race by id' do
    running_race = client.running_race(1577)
    expect(running_race).to be_a Strava::Models::RunningRace
  end
end

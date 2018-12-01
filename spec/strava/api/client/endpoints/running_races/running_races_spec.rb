require 'spec_helper'

RSpec.describe 'Strava::Api::Client#running_races' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns running races', vcr: { cassette_name: 'client/running_races' } do
    running_races = client.running_races
    expect(running_races).to be_a Enumerable

    running_race = running_races.first
    expect(running_race).to be_a Strava::Models::RunningRace
    expect(running_race.id).to eq 1577
    expect(running_race.resource_state).to eq 2
    expect(running_race.name).to eq 'Walt Disney World Marathon 10k'
    expect(running_race.running_race_type).to eq 0
    expect(running_race.distance).to eq 10_000.0
    expect(running_race.distance_s).to eq '10km'
    expect(running_race.start_date_local).to be_a Time
    expect(running_race.city).to eq 'Orlando'
    expect(running_race.state).to eq 'FL'
    expect(running_race.country).to eq 'United States'
    expect(running_race.route_ids).to eq nil
    expect(running_race.measurement_preference).to eq 'meters'
    expect(running_race.url).to eq '2018-walt-disney-world-marathon-10k'
    expect(running_race.strava_url).to eq 'https://www.strava.com/running-races/2018-walt-disney-world-marathon-10k'
    expect(running_race.website_url).to eq nil

    running_race_with_feet_preferences = running_races[1]
    expect(running_race_with_feet_preferences.name).to eq 'Walt Disney World Half Marathon'
    expect(running_race_with_feet_preferences.distance).to eq 21_097.0
    expect(running_race_with_feet_preferences.measurement_preference).to eq 'feet'
    expect(running_race_with_feet_preferences.distance_s).to eq '13.11mi'
  end
end

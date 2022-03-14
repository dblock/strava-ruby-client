# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_laps', vcr: { cassette_name: 'client/activity_laps' } do
  include_context 'API client'
  it 'returns activity laps' do
    activity_laps = client.activity_laps(id: 1_946_417_534)
    expect(activity_laps).to be_a Enumerable
    expect(activity_laps.count).to eq 1
    lap = activity_laps.first
    expect(lap).to be_a Strava::Models::Lap
    expect(lap.id).to eq 6_270_116_916
    expect(lap.resource_state).to eq 2
    expect(lap.name).to eq 'Lap 1'
    expect(lap.activity).to be_a Strava::Models::Activity
    expect(lap.athlete).to be_a Strava::Models::Athlete
    expect(lap.elapsed_time).to eq 13_306
    expect(lap.moving_time).to eq 13_299
    expect(lap.start_date).to eq Time.new(2018, 11, 0o4, 14, 53, 46, '-00:00').utc
    expect(lap.start_date_local).to eq Time.new(2018, 11, 4, 9, 53, 46, '-05:00')
    expect(lap.distance).to eq 42_882.9
    expect(lap.start_index).to eq 0
    expect(lap.end_index).to eq 13_128
    expect(lap.total_elevation_gain).to eq 270.9
    expect(lap.average_speed).to eq 3.22
    expect(lap.max_speed).to eq 5.6
    expect(lap.average_heartrate).to eq 170.1
    expect(lap.max_heartrate).to eq 187.0
    expect(lap.lap_index).to eq 1
    expect(lap.split).to eq 1
    expect(lap.pace_zone).to eq 2
  end
  it 'returns activity laps by id' do
    activity_laps = client.activity_laps(1_946_417_534)
    expect(activity_laps).to be_a Enumerable
    expect(activity_laps.count).to eq 1
  end
end

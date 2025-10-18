# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_laps', vcr: { cassette_name: 'client/activity_laps' } do
  include_context 'with API client'
  it 'returns activity laps' do
    activity_laps = client.activity_laps(id: 15_605_032_352)
    expect(activity_laps).to be_a Enumerable
    expect(activity_laps.count).to eq 1
    lap = activity_laps.first
    expect(lap).to be_a Strava::Models::Lap
    expect(lap.id).to eq 55_554_683_802
    expect(lap.resource_state).to eq 2
    expect(lap.name).to eq 'Lap 1'
    expect(lap.activity).to be_a Strava::Models::MetaActivity
    expect(lap.athlete).to be_a Strava::Models::MetaAthlete
    expect(lap.elapsed_time).to eq 1008
    expect(lap.moving_time).to eq 1008
    expect(lap.start_date).to eq Time.parse('2025-08-27 13:54:22 UTC')
    expect(lap.start_date_local).to eq Time.parse('2025-08-27 09:54:22 -0400')
    expect(lap.distance).to eq 133.46
    expect(lap.start_index).to eq 0
    expect(lap.end_index).to eq 94
    expect(lap.total_elevation_gain).to eq 0
    expect(lap.average_speed).to eq 0.13
    expect(lap.max_speed).to eq 0.826316
    expect(lap.average_heartrate).to eq 124.9
    expect(lap.max_heartrate).to eq 181.0
    expect(lap.lap_index).to eq 1
    expect(lap.split).to eq 1
    expect(lap.pace_zone).to be_nil
  end

  it 'returns activity laps by id' do
    activity_laps = client.activity_laps(15_605_032_352)
    expect(activity_laps).to be_a Enumerable
    expect(activity_laps.count).to eq 1
  end
end

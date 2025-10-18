# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_stats', vcr: { cassette_name: 'client/athlete_stats' } do
  include_context 'with API client'
  it 'returns athlete stats' do
    athlete_stats = client.athlete_stats(id: 26_462_176)
    expect(athlete_stats).to be_a Strava::Models::ActivityStats
    expect(athlete_stats.biggest_ride_distance).to be_nil
    expect(athlete_stats.biggest_climb_elevation_gain).to be_nil
    expect(athlete_stats.recent_ride_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.recent_run_totals).to be_a Strava::Models::ActivityTotal
    recent_run_totals = athlete_stats.recent_run_totals
    expect(recent_run_totals.count).to eq 19
    expect(recent_run_totals.distance).to eq 302_230.89999999997
    expect(recent_run_totals.distance_s).to eq '302.23km'
    expect(recent_run_totals.moving_time).to eq 109_086
    expect(recent_run_totals.moving_time_in_hours_s).to eq '6h18m6s'
    expect(recent_run_totals.elapsed_time).to eq 110_428
    expect(recent_run_totals.elapsed_time_in_hours_s).to eq '6h40m28s'
    expect(recent_run_totals.elevation_gain).to eq 1639.0
    expect(recent_run_totals.elevation_gain_s).to eq '1639m'
    expect(recent_run_totals.achievement_count).to eq 0
    expect(athlete_stats.recent_swim_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.ytd_ride_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.ytd_run_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.ytd_swim_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.all_ride_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.all_run_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.all_swim_totals).to be_a Strava::Models::ActivityTotal
  end

  it 'returns athlete stats by id' do
    athlete_stats = client.athlete_stats(26_462_176)
    expect(athlete_stats).to be_a Strava::Models::ActivityStats
  end
end

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_stats', vcr: { cassette_name: 'client/athlete_stats' } do
  include_context 'API client'
  it 'returns athlete stats' do
    athlete_stats = client.athlete_stats(id: 26_462_176)
    expect(athlete_stats).to be_a Strava::Models::ActivityStats
    expect(athlete_stats.biggest_ride_distance).to eq nil
    expect(athlete_stats.biggest_climb_elevation_gain).to eq nil
    expect(athlete_stats.recent_ride_totals).to be_a Strava::Models::ActivityTotal
    expect(athlete_stats.recent_run_totals).to be_a Strava::Models::ActivityTotal
    recent_run_totals = athlete_stats.recent_run_totals
    expect(recent_run_totals.count).to eq 7
    expect(recent_run_totals.distance).to eq 78_049.90087890625
    expect(recent_run_totals.distance_s).to eq '78.05km'
    expect(recent_run_totals.moving_time).to eq 25_647
    expect(recent_run_totals.moving_time_in_hours_s).to eq '7h7m27s'
    expect(recent_run_totals.elapsed_time).to eq 26_952
    expect(recent_run_totals.elapsed_time_in_hours_s).to eq '7h29m12s'
    expect(recent_run_totals.elevation_gain).to eq 595.4644241333008
    expect(recent_run_totals.total_elevation_gain_s).to eq '595.5m'
    expect(recent_run_totals.achievement_count).to eq 19
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

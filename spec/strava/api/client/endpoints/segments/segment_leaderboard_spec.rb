require 'spec_helper'

RSpec.describe 'Strava::Api::Client#segment_leaderboard' do
  include_context 'API client'
  it 'returns a page of segment leaderboard', vcr: { cassette_name: 'client/segment_leaderboard' } do
    segment_leaderboard = client.segment_leaderboard(id: 1_109_718)
    expect(segment_leaderboard.effort_count).to eq 204
    expect(segment_leaderboard.entry_count).to eq 204
    expect(segment_leaderboard.kom_type).to eq 'kom'
    expect(segment_leaderboard.entries).to be_a Enumerable
    entry = segment_leaderboard.entries.first
    expect(entry).to be_a Strava::Models::SegmentLeaderboardEntry
    expect(entry.athlete_name).to eq 'Etan B.'
    expect(entry.moving_time_in_hours_s).to eq '1m32s'
    expect(entry.start_date).to be_a Time
    expect(entry.start_date_local).to be_a Time
    expect(entry.rank).to eq 1
  end
  it 'returns a page of segment leaderboard by id', vcr: { cassette_name: 'client/segment_leaderboard' } do
    segment_leaderboard = client.segment_leaderboard(1_109_718)
    expect(segment_leaderboard.effort_count).to eq 204
  end
  it 'paginates through the entire segment leaderboard', vcr: { cassette_name: 'client/all_segment_leaderboard' } do
    entries = []
    client.segment_leaderboard(id: 1_109_718, per_page: 100) do |row|
      entries.concat(row.entries)
    end
    expect(entries.count).to eq 204
  end
  it 'paginates through the entire segment leaderboard by id', vcr: { cassette_name: 'client/all_segment_leaderboard' } do
    entries = []
    client.segment_leaderboard(1_109_718, per_page: 100) do |row|
      entries.concat(row.entries)
    end
    expect(entries.count).to eq 204
  end
end

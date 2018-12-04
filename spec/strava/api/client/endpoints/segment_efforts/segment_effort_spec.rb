require 'spec_helper'

RSpec.describe 'Strava::Api::Client#segment_effort', vcr: { cassette_name: 'client/segment_effort' } do
  include_context 'API client'
  it 'returns a segment effort' do
    segment_effort = client.segment_effort(id: 41_494_197_089)
    expect(segment_effort).to be_a Strava::Models::SegmentEffort
    expect(segment_effort.id).to eq 41_494_197_089
    expect(segment_effort.achievements).to be_a Enumerable
    achievement = segment_effort.achievements.first
    expect(achievement).to be_a Strava::Models::Achievement
    expect(achievement.rank).to eq 1
    expect(achievement.type).to eq 'pr'
    expect(achievement.type_id).to eq 3
    expect(segment_effort.resource_state).to eq 3
    expect(segment_effort.name).to eq 'E 14th St Climb'
    expect(segment_effort.activity).to be_a Strava::Models::Activity
    expect(segment_effort.athlete).to be_a Strava::Models::Athlete
    expect(segment_effort.elapsed_time).to eq 116
    expect(segment_effort.moving_time).to eq 116
    expect(segment_effort.start_date).to be_a Time
    expect(segment_effort.start_date_local).to be_a Time
    expect(segment_effort.distance).to eq 398.6
    expect(segment_effort.distance_s).to eq '0.4km'
    expect(segment_effort.start_index).to eq 109
    expect(segment_effort.end_index).to eq 225
    expect(segment_effort.average_heartrate).to eq 152.2
    expect(segment_effort.max_heartrate).to eq 158.0
    expect(segment_effort.athlete_segment_stats).to be_a Enumerable
    segment_stats = segment_effort.athlete_segment_stats
    expect(segment_stats).to be_a Strava::Models::SegmentStats
    expect(segment_stats.pr_elapsed_time).to eq 116
    expect(segment_stats.elapsed_time_in_hours_s).to eq '1m56s'
    expect(segment_stats.pr_date).to be_a Date
    expect(segment_stats.pr_date).to eq Date.new(2018, 6, 22)
    expect(segment_stats.effort_count).to eq 3
  end
  it 'returns a segment effort by id' do
    segment_effort = client.segment_effort(41_494_197_089)
    expect(segment_effort).to be_a Strava::Models::SegmentEffort
  end
end

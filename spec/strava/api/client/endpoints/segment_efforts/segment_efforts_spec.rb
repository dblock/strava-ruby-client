require 'spec_helper'

RSpec.describe 'Strava::Api::Client#segment_efforts', vcr: { cassette_name: 'client/segment_efforts' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns segment efforts' do
    segment_efforts = client.segment_efforts(id: 1_109_718)
    expect(segment_efforts).to be_a Enumerable
    expect(segment_efforts.count).to eq 3
    segment_effort = segment_efforts.first
    expect(segment_effort).to be_a Strava::Models::SegmentEffort
    expect(segment_effort.id).to eq 41_494_197_089
    expect(segment_effort.achievements).to be_a Enumerable
    achievement = segment_effort.achievements.first
    expect(achievement).to be_a Strava::Models::Achievement
    expect(achievement.rank).to eq 1
    expect(achievement.type).to eq 'pr'
    expect(achievement.type_id).to eq 3
    expect(segment_effort.resource_state).to eq 2
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
  end
  it 'returns segment efforts by id' do
    segment_efforts = client.segment_efforts(1_109_718)
    expect(segment_efforts).to be_a Enumerable
    expect(segment_efforts.count).to eq 3
  end
end

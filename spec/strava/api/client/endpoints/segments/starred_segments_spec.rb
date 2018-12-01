require 'spec_helper'

RSpec.describe 'Strava::Api::Client#starred_segments' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns starred segments', vcr: { cassette_name: 'client/starred_segments' } do
    segments = client.starred_segments
    expect(segments).to be_a Enumerable
    segment = segments.first
    expect(segment).to be_a Strava::Models::Segment
    expect(segment.pr_time).to eq 256
    expect(segment.elapsed_time_in_hours_s).to eq '4m16s'
    expect(segment.starred_date).to be_a Time
    expect(segment.athlete_pr_effort).to be_a Strava::Models::SegmentEffort
  end
end

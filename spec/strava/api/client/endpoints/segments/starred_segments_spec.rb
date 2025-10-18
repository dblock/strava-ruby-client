# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#starred_segments' do
  include_context 'with API client'
  it 'returns starred segments', vcr: { cassette_name: 'client/starred_segments' } do
    segments = client.starred_segments
    expect(segments).to be_a Enumerable
    segment = segments.first
    expect(segment).to be_a Strava::Models::SummarySegment
    expect(segment.pr_time).to eq 256
    expect(segment.starred_date).to be_a Time
    expect(segment.athlete_pr_effort).to be_a Strava::Models::SummaryPRSegmentEffort
  end
end

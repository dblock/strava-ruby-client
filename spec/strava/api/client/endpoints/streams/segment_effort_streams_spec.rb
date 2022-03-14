# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#segment_effort_streams', vcr: { cassette_name: 'client/segment_effort_streams' } do
  include_context 'API client'
  it 'returns segment effort streams' do
    streams = client.segment_effort_streams(id: 41_494_197_089)
    expect(streams).to be_a Strava::Models::StreamSet
    distance = streams.distance
    expect(distance).to be_a Strava::Models::Stream
    expect(distance.original_size).to eq 117
    expect(distance.resolution).to eq 'high'
    expect(distance.series_type).to eq 'distance'
    expect(distance.data.size).to eq 117
  end
  it 'returns segment effort streams by id' do
    streams = client.segment_effort_streams(41_494_197_089)
    expect(streams).to be_a Strava::Models::StreamSet
  end
end

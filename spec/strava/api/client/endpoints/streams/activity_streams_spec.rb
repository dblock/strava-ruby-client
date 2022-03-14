# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_streams', vcr: { cassette_name: 'client/activity_streams' } do
  include_context 'API client'
  it 'returns activity streams' do
    streams = client.activity_streams(id: 1_946_417_534)
    expect(streams).to be_a Strava::Models::StreamSet
    distance = streams.distance
    expect(distance).to be_a Strava::Models::Stream
    expect(distance.original_size).to eq 13_129
    expect(distance.resolution).to eq 'high'
    expect(distance.series_type).to eq 'distance'
    expect(distance.data.size).to eq 13_129
  end
  it 'returns activity streams by id' do
    streams = client.activity_streams(1_946_417_534)
    expect(streams).to be_a Strava::Models::StreamSet
  end
end

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#segment_streams' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns segment streams', vcr: { cassette_name: 'client/segment_streams' } do
    streams = client.segment_streams(id: 1_109_718)
    expect(streams).to be_a Strava::Models::StreamSet
    distance = streams.distance
    expect(distance).to be_a Strava::Models::Stream
    expect(distance.original_size).to eq 32
    expect(distance.resolution).to eq 'high'
    expect(distance.series_type).to eq 'distance'
    expect(distance.data.size).to eq 32
  end
  it 'returns multiple keys', vcr: { cassette_name: 'client/segment_streams_keys' } do
    streams = client.segment_streams(id: 1_109_718, keys: %w[
                                       distance
                                       latlng
                                       altitude
                                     ])
    expect(streams).to be_a Strava::Models::StreamSet
    expect(streams.distance).to be_a Strava::Models::Stream
    expect(streams.latlng).to be_a Strava::Models::Stream
    expect(streams.altitude).to be_a Strava::Models::Stream
  end
end

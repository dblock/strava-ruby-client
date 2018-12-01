require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_streams' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns activity streams', vcr: { cassette_name: 'client/activity_streams' } do
    streams = client.activity_streams(id: 1_946_417_534)
    expect(streams).to be_a Strava::Models::StreamSet
    distance = streams.distance
    expect(distance).to be_a Strava::Models::Stream
    expect(distance.original_size).to eq 13_129
    expect(distance.resolution).to eq 'high'
    expect(distance.series_type).to eq 'distance'
    expect(distance.data.size).to eq 13_129
  end
end

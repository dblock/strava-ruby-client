require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_zones', vcr: { cassette_name: 'client/activity_zones' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns activity zones' do
    activity_zones = client.activity_zones(id: 1_946_417_534)
    expect(activity_zones).to be_a Enumerable
    expect(activity_zones.count).to eq 2
    activity_zone = activity_zones.first
    expect(activity_zone).to be_a Strava::Models::ActivityZone
    expect(activity_zone.score).to eq 656
    expect(activity_zone.distribution_buckets).to be_a Enumerable
    distribution_bucket = activity_zone.distribution_buckets.first
    expect(distribution_bucket).to be_a Strava::Models::TimedZoneRange
    expect(distribution_bucket.min).to eq 0
    expect(distribution_bucket.max).to eq 123
    expect(distribution_bucket.time).to eq 20
    expect(activity_zone.type).to eq 'heartrate'
    expect(activity_zone.resource_state).to eq 3
    expect(activity_zone.sensor_based).to be true
    expect(activity_zone.points).to eq 452
    expect(activity_zone.custom_zones).to be false
  end
  it 'returns activity zones by id' do
    activity_zones = client.activity_zones(1_946_417_534)
    expect(activity_zones).to be_a Enumerable
    expect(activity_zones.count).to eq 2
  end
end

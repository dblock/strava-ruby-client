# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_zones', vcr: { cassette_name: 'client/athlete_zones' } do
  include_context 'API client'
  it 'returns athlete zones' do
    athlete_zones = client.athlete_zones
    expect(athlete_zones).to be_a Strava::Models::Zones
    heart_rate = athlete_zones.heart_rate
    expect(heart_rate).to be_a Strava::Models::HeartRateZoneRanges
    expect(heart_rate.custom_zones).to be false
    zones = heart_rate.zones
    expect(zones).to be_a Enumerable
    zone = zones.first
    expect(zone).to be_a Strava::Models::ZoneRange
    expect(zone.min).to eq 0
    expect(zone.max).to eq 123
    power = athlete_zones.power
    expect(power).to be_a Strava::Models::PowerZoneRanges
    zones = power.zones
    expect(zones).to be_a Enumerable
    zone = power.zones.first
    expect(zone).to be_a Strava::Models::ZoneRange
    expect(zone.min).to eq 0
    expect(zone.max).to eq 10
  end
end

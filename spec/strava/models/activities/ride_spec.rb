# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::Activity do
  let(:fixtures) { 'spec/fixtures/strava/models/activities' }
  let(:json) { JSON.parse(File.read("#{fixtures}/#{activity_type}.json")) }
  let(:activity) { Strava::Models::Activity.new(json) }
  describe 'ride' do
    let(:activity_type) { 'ride' }
    it 'exposes custom properties' do
      expect(activity.strava_url).to eq 'https://www.strava.com/activities/1493471377'
      expect(activity.type_emoji).to eq '🚴'
      expect(activity.sport_type_emoji).to eq '🚴'
    end
    it 'converts distances' do
      expect(activity.distance_in_miles).to eq 17.45987563
      expect(activity.distance_in_miles_s).to eq '17.46mi'
      expect(activity.distance_in_yards).to eq 30_729.34739
      expect(activity.distance_in_yards_s).to eq '30729.3yd'
      expect(activity.distance_in_meters).to eq 28_099
      expect(activity.distance_in_meters_s).to eq '28099m'
      expect(activity.distance_in_kilometers).to eq 28
      expect(activity.distance_in_kilometers_s).to eq '28km'
      expect(activity.distance_s).to eq '28km'
    end
    it 'converts pace and speed' do
      expect(activity.moving_time_in_hours_s).to eq '1h10m7s'
      expect(activity.elapsed_time_in_hours_s).to eq '1h13m30s'
      expect(activity.pace_per_mile_s).to eq '4m01s/mi'
      expect(activity.pace_per_100_yards_s).to eq '0m14s/100yd'
      expect(activity.pace_per_100_meters_s).to eq '0m15s/100m'
      expect(activity.pace_per_kilometer_s).to eq '2m30s/km'
      expect(activity.pace_s).to eq '2m30s/km'
      expect(activity.kilometer_per_hour_s).to eq '24.0km/h'
      expect(activity.miles_per_hour_s).to eq '14.9mph'
      expect(activity.speed_s).to eq '24.0km/h'
    end
    it 'converts elevation' do
      expect(activity.total_elevation_gain_in_feet).to eq 1692.91344
      expect(activity.total_elevation_gain_in_meters).to eq 516
      expect(activity.total_elevation_gain_in_meters_s).to eq '516m'
      expect(activity.total_elevation_gain_in_feet_s).to eq '1692.9ft'
      expect(activity.total_elevation_gain_s).to eq '516m'
    end
  end
end

require 'spec_helper'

RSpec.describe Strava::Models::Activity do
  let(:fixtures) { 'spec/fixtures/strava/models/activities' }
  let(:json) { JSON.parse(File.read("#{fixtures}/#{activity_type}.json")) }
  let(:activity) { Strava::Models::Activity.new(json) }
  describe 'swim' do
    let(:activity_type) { 'swim' }
    it 'exposes custom properties' do
      expect(activity.strava_url).to eq 'https://www.strava.com/activities/1493471377'
      expect(activity.type_emoji).to eq '🏊'
    end
    it 'converts distances' do
      expect(activity.distance_in_miles).to eq 1.164758065
      expect(activity.distance_in_miles_s).to eq '1.16mi'
      expect(activity.distance_in_yards).to eq 2049.971945
      expect(activity.distance_in_yards_s).to eq '2050yd'
      expect(activity.distance_in_meters).to eq 1874.5
      expect(activity.distance_in_meters_s).to eq '1874m'
      expect(activity.distance_in_kilometers).to eq 1.8745
      expect(activity.distance_in_kilometers_s).to eq '1.87km'
      expect(activity.distance_s).to eq '1874m'
    end
    it 'converts pace and speed' do
      expect(activity.moving_time_in_hours_s).to eq '37m'
      expect(activity.elapsed_time_in_hours_s).to eq '37m'
      expect(activity.pace_per_mile_s).to eq '31m47s/mi'
      expect(activity.pace_per_100_yards_s).to eq '1m48s/100yd'
      expect(activity.pace_per_100_meters_s).to eq '1m58s/100m'
      expect(activity.pace_per_kilometer_s).to eq '19m45s/km'
      expect(activity.pace_s).to eq '1m58s/100m'
      expect(activity.kilometer_per_hour_s).to eq '3.0km/h'
      expect(activity.miles_per_hour_s).to eq '1.9mph'
      expect(activity.speed_s).to eq '3.0km/h'
    end
    it 'converts elevation' do
      expect(activity.total_elevation_gain_in_feet).to eq 0.0
      expect(activity.total_elevation_gain_in_meters).to eq 0.0
      expect(activity.total_elevation_gain_in_meters_s).to be nil
      expect(activity.total_elevation_gain_in_feet_s).to be nil
      expect(activity.total_elevation_gain_s).to be nil
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::Activity do
  let(:fixtures) { 'spec/fixtures/strava/models/activities' }
  let(:json) { JSON.parse(File.read("#{fixtures}/#{activity_type}.json")) }
  let(:activity) { Strava::Models::Activity.new(json) }
  describe 'run' do
    let(:activity_type) { 'run' }
    it 'exposes custom properties' do
      expect(activity.strava_url).to eq 'https://www.strava.com/activities/1477353766'
      expect(activity.type_emoji).to eq '🏃'
      expect(activity.sport_type_emoji).to eq '🏃'
    end
    it 'converts distances' do
      expect(activity.distance_in_miles).to eq 14.005431252
      expect(activity.distance_in_miles_s).to eq '14.01mi'
      expect(activity.distance_in_yards).to eq 24_649.531956
      expect(activity.distance_in_yards_s).to eq '24649.5yd'
      expect(activity.distance_in_meters).to eq 22_539.6
      expect(activity.distance_in_meters_s).to eq '22539m'
      expect(activity.distance_in_kilometers).to eq 22.5396
      expect(activity.distance_in_kilometers_s).to eq '22.54km'
      expect(activity.distance_s).to eq '22.54km'
    end
    it 'converts pace and speed' do
      expect(activity.moving_time_in_hours_s).to eq '2h6m26s'
      expect(activity.elapsed_time_in_hours_s).to eq '2h8m6s'
      expect(activity.pace_per_mile_s).to eq '9m02s/mi'
      expect(activity.pace_per_100_yards_s).to eq '0m31s/100yd'
      expect(activity.pace_per_100_meters_s).to eq '0m34s/100m'
      expect(activity.pace_per_kilometer_s).to eq '5m37s/km'
      expect(activity.pace_s).to eq '5m37s/km'
      expect(activity.kilometer_per_hour_s).to eq '10.7km/h'
      expect(activity.miles_per_hour_s).to eq '6.6mph'
      expect(activity.speed_s).to eq '10.7km/h'
    end
    it 'converts elevation' do
      expect(activity.total_elevation_gain_in_feet).to eq(-475.39371600000004)
      expect(activity.total_elevation_gain_in_meters).to eq(-144.9)
      expect(activity.total_elevation_gain_in_meters_s).to eq '-144.9m'
      expect(activity.total_elevation_gain_in_feet_s).to eq '-475.4ft'
      expect(activity.total_elevation_gain_s).to eq '-144.9m'
    end
  end
end

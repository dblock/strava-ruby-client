# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a single training zone range.
    #
    # Training zones define intensity levels for heart rate or power. Each zone
    # has a minimum and maximum value that defines the range for that intensity level.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-ZoneRange Strava API ZoneRange reference
    # @see Strava::Models::HeartRateZoneRanges
    # @see Strava::Models::PowerZoneRanges
    # @see Strava::Models::TimedZoneRange
    #
    # @example Accessing zone ranges
    #   zones = client.athlete_zones
    #   zones.heart_rate.zones.each_with_index do |zone, i|
    #     puts "Zone #{i + 1}: #{zone.min}-#{zone.max} bpm"
    #   end
    #
    class ZoneRange < Strava::Models::Response
      # @return [Integer] Maximum value for this zone (e.g., maximum heart rate or power)
      property 'max'

      # @return [Integer] Minimum value for this zone (e.g., minimum heart rate or power)
      property 'min'
    end
  end
end

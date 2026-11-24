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

      # Hashie >= 6 does not define property readers that conflict with existing methods.
      if Gem::Version.new(Hashie::VERSION) >= Gem::Version.new('6.0')
        def max
          self['max']
        end
      end

      # @return [Integer] Minimum value for this zone (e.g., minimum heart rate or power)
      property 'min'

      # Hashie >= 6 does not define property readers that conflict with existing methods.
      if Gem::Version.new(Hashie::VERSION) >= Gem::Version.new('6.0')
        def min
          self['min']
        end
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an athlete's training zones configuration.
    #
    # Training zones are used to define intensity levels for heart rate and power.
    # These zones help athletes train at specific intensities and track time spent
    # in each zone during activities.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-Zones Strava API Zones reference
    # @see Strava::Models::HeartRateZoneRanges
    # @see Strava::Models::PowerZoneRanges
    # @see Strava::Api::Client#athlete_zones
    #
    # @example Accessing athlete's training zones
    #   zones = client.athlete_zones
    #
    #   # Heart rate zones
    #   if zones.heart_rate
    #     zones.heart_rate.zones.each_with_index do |zone, i|
    #       puts "HR Zone #{i + 1}: #{zone.min}-#{zone.max} bpm"
    #     end
    #   end
    #
    #   # Power zones
    #   if zones.power
    #     zones.power.zones.each_with_index do |zone, i|
    #       puts "Power Zone #{i + 1}: #{zone.min}-#{zone.max}W"
    #     end
    #   end
    #
    class Zones < Strava::Models::Response
      # @return [HeartRateZoneRanges, nil] Heart rate zone configuration with zone ranges
      property 'heart_rate', transform_with: ->(v) { Strava::Models::HeartRateZoneRanges.new(v) }

      # @return [PowerZoneRanges, nil] Power zone configuration with zone ranges (for cyclists)
      property 'power', transform_with: ->(v) { Strava::Models::PowerZoneRanges.new(v) }
    end
  end
end

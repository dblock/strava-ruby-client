# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an athlete's heart rate zone configuration.
    #
    # Heart rate zones define intensity levels based on beats per minute.
    # Athletes can use default zones or configure custom zones based on
    # their fitness level and training goals.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-HeartRateZoneRanges Strava API HeartRateZoneRanges reference
    # @see Strava::Models::ZoneRange
    # @see Strava::Models::Zones
    #
    # @example Accessing heart rate zones
    #   zones = client.athlete_zones
    #
    #   if zones.heart_rate
    #     if zones.heart_rate.custom_zones
    #       puts "Using custom heart rate zones"
    #     else
    #       puts "Using default heart rate zones"
    #     end
    #
    #     zones.heart_rate.zones.each_with_index do |zone, i|
    #       puts "Zone #{i + 1}: #{zone.min}-#{zone.max} bpm"
    #     end
    #   end
    #
    class HeartRateZoneRanges < Strava::Models::Response
      # @return [Boolean] Whether the athlete is using custom heart rate zones
      property 'custom_zones'

      # @return [Array<ZoneRange>] Array of heart rate zone ranges
      property 'zones', transform_with: ->(v) { v.map { |r| Strava::Models::ZoneRange.new(r) } }
    end
  end
end

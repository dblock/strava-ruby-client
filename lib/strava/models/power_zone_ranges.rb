# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an athlete's power zone configuration.
    #
    # Power zones define intensity levels based on watts output. These are
    # typically used for cycling training and are often based on FTP
    # (Functional Threshold Power).
    #
    # @see https://developers.strava.com/docs/reference/#api-models-PowerZoneRanges Strava API PowerZoneRanges reference
    # @see Strava::Models::ZoneRange
    # @see Strava::Models::Zones
    #
    # @example Accessing power zones
    #   zones = client.athlete_zones
    #
    #   if zones.power
    #     zones.power.zones.each_with_index do |zone, i|
    #       puts "Power Zone #{i + 1}: #{zone.min}-#{zone.max}W"
    #     end
    #   else
    #     puts "No power zones configured"
    #   end
    #
    class PowerZoneRanges < Strava::Models::Response
      # @return [Array<ZoneRange>] Array of power zone ranges in watts
      property 'zones', transform_with: ->(v) { v.map { |r| Strava::Models::ZoneRange.new(r) } }
    end
  end
end

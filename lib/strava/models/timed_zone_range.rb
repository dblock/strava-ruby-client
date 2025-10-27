# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a training zone range with time spent in that zone.
    #
    # Used in activity zone distributions to show how much time was spent
    # at different intensity levels during an activity.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-TimedZoneRange Strava API TimedZoneRange reference
    # @see Strava::Models::ZoneRange
    # @see Strava::Models::ActivityZone
    #
    # @example Viewing time distribution across zones
    #   zones = client.activity_zones(1234567890)
    #   hr_zone = zones.find { |z| z.type == 'heartrate' }
    #
    #   hr_zone.distribution_buckets.each_with_index do |bucket, i|
    #     minutes = bucket.time / 60
    #     puts "Zone #{i + 1} (#{bucket.min}-#{bucket.max} bpm): #{minutes} minutes"
    #   end
    #
    class TimedZoneRange < Strava::Models::Response
      # @return [Integer] Maximum value for this zone (e.g., maximum heart rate or power)
      property 'max'

      # @return [Integer] Minimum value for this zone (e.g., minimum heart rate or power)
      property 'min'

      # @return [Integer] Time spent in this zone in seconds
      property 'time'
    end
  end
end

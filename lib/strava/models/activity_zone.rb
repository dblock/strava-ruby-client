# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents time spent in heart rate or power zones during an activity.
    #
    # Activity zones show how much time was spent at different intensity levels,
    # which helps analyze training load and effort distribution. Each zone bucket
    # contains the time spent in that zone range.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-ActivityZone Strava API ActivityZone reference
    # @see Strava::Models::TimedZoneRange
    # @see Strava::Api::Client#activity_zones
    #
    # @example Analyzing time in heart rate zones
    #   zones = client.activity_zones(1234567890)
    #   hr_zone = zones.find { |z| z.type == 'heartrate' }
    #
    #   if hr_zone
    #     puts "Max HR: #{hr_zone.max}"
    #     puts "Sensor-based: #{hr_zone.sensor_based}"
    #     hr_zone.distribution_buckets.each_with_index do |bucket, i|
    #       puts "Zone #{i + 1}: #{bucket.time} seconds (#{bucket.min}-#{bucket.max} bpm)"
    #     end
    #   end
    #
    class ActivityZone < Strava::Models::Response
      # @return [Integer, nil] Relative effort score for this activity
      property 'score'

      # @return [Array<TimedZoneRange>] Array of time spent in each zone bucket
      property 'distribution_buckets', transform_with: ->(v) { v.map { |r| Strava::Models::TimedZoneRange.new(r) } }

      # @return [String] Type of zone data ("heartrate" or "power")
      property 'type'

      # @return [Boolean] Whether data comes from a sensor (vs. estimated)
      property 'sensor_based'

      # @return [Integer, nil] Points or score accumulated in this zone
      property 'points'

      # @return [Boolean] Whether custom zones are being used
      property 'custom_zones'

      # @return [Integer, nil] Maximum value recorded (e.g., max heart rate in bpm)
      property 'max'

      # @return [Integer] Resource state indicator
      # @note Not documented by Strava API
      property 'resource_state'
    end
  end
end

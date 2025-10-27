# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a split/interval within an activity.
    #
    # Splits divide an activity into equal distance segments (e.g., per mile or per kilometer)
    # with metrics for each segment. Activities typically include both metric (km) and
    # standard (mile) splits.
    #
    # Includes helper mixins for formatting distance, time, speed, and elevation.
    #
    # @example Access activity splits
    #   activity = client.activity(1234567890)
    #   activity.splits_metric.each_with_index do |split, i|
    #     puts "KM #{i+1}: #{split.moving_time_in_hours_s} at #{split.pace_s}"
    #     puts "Elevation: #{split.elevation_difference}m"
    #   end
    #
    # @see https://developers.strava.com/docs/reference/#api-models-Split
    #
    class Split < Strava::Models::Response
      include Mixins::AverageSpeed
      include Mixins::Distance
      include Mixins::ElapsedTime
      include Mixins::ElevationDifference

      # @return [Integer] Pace zone for this split (0-5)
      property 'pace_zone'

      include Mixins::MovingTime

      # @return [Integer] Split number (1-indexed)
      property 'split'

      # @return [Float] Average speed adjusted for grade/incline (in meters per second)
      property 'average_grade_adjusted_speed'

      # @return [Float] Average heart rate during this split (beats per minute)
      property 'average_heartrate'
    end
  end
end

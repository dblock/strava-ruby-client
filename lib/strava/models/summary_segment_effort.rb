# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a summary of a segment effort within an activity.
    #
    # A segment effort is an attempt at a defined segment (a portion of road or trail).
    # This summary version contains basic information about the effort without
    # detailed statistics.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-SummarySegmentEffort Strava API SummarySegmentEffort reference
    # @see Strava::Models::DetailedSegmentEffort
    # @see Strava::Models::DetailedActivity#segment_efforts
    #
    # @example Accessing segment efforts from an activity
    #   activity = client.activity(1234567890)
    #   activity.segment_efforts.each do |effort|
    #     puts "#{effort.name}: #{effort.elapsed_time_in_hours_s}"
    #     puts "  KOM: #{effort.is_kom}"
    #     puts "  Distance: #{effort.distance_s}"
    #   end
    #
    class SummarySegmentEffort < Strava::Models::Response
      # @return [Integer] Unique identifier for this segment effort
      property 'id'

      # @return [Integer] ID of the activity containing this segment effort
      property 'activity_id'

      # Includes elapsed_time (total time including stops) and helper methods
      include Mixins::ElapsedTime

      # @return [Time] Start time of the segment effort in UTC
      property 'start_date', transform_with: ->(v) { Time.parse(v) }

      # Includes start_date_local with timezone handling
      include Mixins::StartDateLocal

      # Includes distance in meters and conversion helper methods
      include Mixins::Distance

      # @return [Boolean] Whether this effort achieved KOM (King/Queen of the Mountain)
      property 'is_kom'
    end
  end
end

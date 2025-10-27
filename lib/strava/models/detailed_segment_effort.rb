# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents detailed information about a segment effort within an activity.
    #
    # A segment effort is an attempt at a defined segment (a portion of road or trail).
    # The detailed version includes comprehensive statistics, rankings, achievements,
    # and sensor data for the effort.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-DetailedSegmentEffort Strava API DetailedSegmentEffort reference
    # @see Strava::Models::SummarySegmentEffort
    # @see Strava::Models::SummarySegment
    # @see Strava::Models::Achievement
    #
    # @example Accessing detailed segment effort
    #   effort = client.segment_effort(1234567890)
    #
    #   puts "Segment: #{effort.name}"
    #   puts "Time: #{effort.elapsed_time_in_hours_s}"
    #   puts "Moving time: #{effort.moving_time_in_hours_s}"
    #   puts "Distance: #{effort.distance_s}"
    #
    #   if effort.average_watts
    #     puts "Avg Power: #{effort.average_watts}W"
    #   end
    #
    #   if effort.average_heartrate
    #     puts "Avg HR: #{effort.average_heartrate} bpm (max: #{effort.max_heartrate})"
    #   end
    #
    #   # Check rankings
    #   puts "KOM Rank: #{effort.kom_rank}" if effort.kom_rank
    #   puts "PR Rank: #{effort.pr_rank}" if effort.pr_rank
    #
    #   # View achievements
    #   effort.achievements.each do |achievement|
    #     puts "Achievement: #{achievement.type} - Rank #{achievement.rank}"
    #   end
    #
    class DetailedSegmentEffort < Strava::Models::Response
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

      # @return [String] Name of the segment
      property 'name'

      # @return [MetaActivity] Reference to the parent activity
      property 'activity', transform_with: ->(v) { Strava::Models::MetaActivity.new(v) }

      # @return [MetaAthlete] Reference to the athlete who performed this effort
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }

      # Includes moving_time (time excluding stops) and helper methods
      include Mixins::MovingTime

      # @return [Integer] Index in the activity stream where this effort starts
      property 'start_index'

      # @return [Integer] Index in the activity stream where this effort ends
      property 'end_index'

      # @return [Float, nil] Average cadence during the effort (RPM for cycling, steps/min for running)
      property 'average_cadence'

      # @return [Float, nil] Average power output during the effort in watts
      property 'average_watts'

      # @return [Boolean, nil] Whether power data comes from a power meter device
      property 'device_watts'

      # @return [Float, nil] Average heart rate during the effort in beats per minute
      property 'average_heartrate'

      # @return [Integer, nil] Maximum heart rate during the effort in beats per minute
      property 'max_heartrate'

      # @return [SummarySegment] The segment that was attempted
      property 'segment', transform_with: ->(v) { Strava::Models::SummarySegment.new(v) }

      # @return [Integer, nil] Overall rank on this segment (null if not in top 10)
      property 'kom_rank'

      # @return [Integer, nil] Personal record rank for this segment (1 for PR, 2 for 2nd best, etc.)
      property 'pr_rank'

      # @return [Boolean] Whether this effort is hidden from public segment leaderboards
      property 'hidden'

      # @return [Integer] Resource state indicator
      # @note Not documented by Strava API
      property 'resource_state'

      # @return [Array<Achievement>] Achievements earned during this effort (PR, yearly records, etc.)
      # @note Not documented by Strava API
      property 'achievements', transform_with: ->(v) { v.map { |r| Strava::Models::Achievement.new(r) } }

      # @return [String, nil] Visibility setting for this effort
      # @note Not documented by Strava API
      property 'visibility'

      # @return [SummaryPRSegmentEffort, nil] Athlete's personal statistics for this segment
      # @note Not documented by Strava API
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SummaryPRSegmentEffort.new(v) }
    end
  end
end

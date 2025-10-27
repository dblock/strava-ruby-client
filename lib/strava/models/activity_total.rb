# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents totals for a specific activity type and time period.
    #
    # Contains aggregated counts, distance, time, and elevation for activities.
    # Used within ActivityStats to break down statistics by activity type
    # (ride, run, swim) and period (recent, YTD, all-time).
    #
    # Includes helper mixins for formatting distance, time, and elevation.
    #
    # @example Access activity totals
    #   stats = client.athlete_stats(12345)
    #   totals = stats.recent_run_totals
    #   puts "#{totals.count} runs"
    #   puts "Total distance: #{totals.distance_s}"
    #   puts "Moving time: #{totals.moving_time_in_hours_s}"
    #   puts "Elevation: #{totals.elevation_gain_s}"
    #   puts "Achievements: #{totals.achievement_count}"
    #
    # @see ActivityStats
    # @see https://developers.strava.com/docs/reference/#api-models-ActivityTotal
    #
    class ActivityTotal < Strava::Models::Response
      # @return [Integer] Number of activities
      property 'count'

      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::ElevationGain

      # @return [Integer] Total number of achievements/trophies earned
      property 'achievement_count'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents aggregated activity statistics for an athlete.
    #
    # Contains totals broken down by activity type (ride, run, swim) and time period
    # (recent, year-to-date, all-time). Recent totals cover the last 4 weeks.
    #
    # @example Get athlete statistics
    #   stats = client.athlete_stats(12345)
    #
    #   # Recent activity
    #   recent = stats.recent_run_totals
    #   puts "Recent runs: #{recent.count} activities"
    #   puts "Distance: #{recent.distance_s}"
    #   puts "Time: #{recent.moving_time_in_hours_s}"
    #
    #   # Year-to-date
    #   ytd = stats.ytd_ride_totals
    #   puts "YTD rides: #{ytd.count} totaling #{ytd.distance_s}"
    #
    #   # All-time records
    #   puts "Biggest ride: #{stats.biggest_ride_distance}m"
    #   puts "Biggest climb: #{stats.biggest_climb_elevation_gain}m"
    #
    # @see ActivityTotal
    # @see https://developers.strava.com/docs/reference/#api-models-ActivityStats
    #
    class ActivityStats < Strava::Models::Response
      # @return [Float] Longest ride distance in meters
      property 'biggest_ride_distance'

      # @return [Float] Most elevation gain in a single activity (meters)
      property 'biggest_climb_elevation_gain'

      # @return [ActivityTotal] Recent ride totals (last 4 weeks)
      property 'recent_ride_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] Recent run totals (last 4 weeks)
      property 'recent_run_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] Recent swim totals (last 4 weeks)
      property 'recent_swim_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] Year-to-date ride totals
      property 'ytd_ride_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] Year-to-date run totals
      property 'ytd_run_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] Year-to-date swim totals
      property 'ytd_swim_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] All-time ride totals
      property 'all_ride_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] All-time run totals
      property 'all_run_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }

      # @return [ActivityTotal] All-time swim totals
      property 'all_swim_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
    end
  end
end

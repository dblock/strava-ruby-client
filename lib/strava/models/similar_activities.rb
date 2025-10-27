# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents statistics about similar activities.
    #
    # Provides comparative data about activities of the same type and route,
    # including speed trends and performance metrics. This model is not documented
    # in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::Trend
    # @see Strava::Models::DetailedActivity
    #
    # @example Accessing similar activity statistics
    #   activity = client.activity(1234567890)
    #   if activity.similar_activities
    #     similar = activity.similar_activities
    #     puts "Average speed: #{similar.average_speed} m/s"
    #     puts "Similar efforts: #{similar.effort_count}"
    #     puts "PR rank: #{similar.pr_rank}"
    #   end
    #
    class SimilarActivities < Strava::Models::Response
      # @return [Float, nil] Average speed across similar activities in meters per second
      # @note Not documented by Strava API
      property 'average_speed'

      # @return [Integer, nil] Resource state indicator
      # @note Not documented by Strava API
      property 'resource_state'

      # @return [Integer, nil] Number of similar efforts/activities
      # @note Not documented by Strava API
      property 'effort_count'

      # @return [Integer, nil] Milestone frequency indicator
      # @note Not documented by Strava API
      property 'frequency_milestone'

      # @return [Float, nil] Maximum average speed across similar activities in meters per second
      # @note Not documented by Strava API
      property 'max_average_speed'

      # @return [Float, nil] Median average speed across similar activities in meters per second
      # @note Not documented by Strava API
      property 'mid_average_speed'

      # @return [Float, nil] Minimum average speed across similar activities in meters per second
      # @note Not documented by Strava API
      property 'min_average_speed'

      # @return [Float, nil] Median speed value
      # @note Not documented by Strava API
      property 'mid_speed'

      # @return [Float, nil] Minimum speed value
      # @note Not documented by Strava API
      property 'min_speed'

      # @return [Array, nil] Array of speed values
      # @note Not documented by Strava API
      property 'speeds'

      # @return [Trend, nil] Trend data for similar activities
      # @note Not documented by Strava API
      property 'trend', transform_with: ->(v) { Strava::Models::Trend.new(v) }

      # @return [Integer, nil] Personal record rank among similar activities
      # @note Not documented by Strava API
      property 'pr_rank'
    end
  end
end

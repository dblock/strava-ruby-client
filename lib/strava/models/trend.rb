# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents performance trend data.
    #
    # Contains trend information about speed and performance over time,
    # showing whether performance is improving, declining, or staying consistent.
    # This model is not documented in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::SimilarActivities
    #
    # @example Accessing trend data
    #   activity = client.activity(1234567890)
    #   if activity.similar_activities&.trend
    #     trend = activity.similar_activities.trend
    #     puts "Trend direction: #{trend.direction}"
    #     puts "Speed range: #{trend.min_speed} - #{trend.max_speed} m/s"
    #     puts "Current activity index: #{trend.current_activity_index}"
    #   end
    #
    class Trend < Strava::Models::Response
      # @return [Array, nil] Array of speed values showing the trend
      # @note Not documented by Strava API
      property 'speeds'

      # @return [Integer, nil] Index of current activity in the trend series
      # @note Not documented by Strava API
      property 'current_activity_index'

      # @return [Float, nil] Minimum speed in the trend in meters per second
      # @note Not documented by Strava API
      property 'min_speed'

      # @return [Float, nil] Median speed in the trend in meters per second
      # @note Not documented by Strava API
      property 'mid_speed'

      # @return [Float, nil] Maximum speed in the trend in meters per second
      # @note Not documented by Strava API
      property 'max_speed'

      # @return [Integer, nil] Trend direction indicator (e.g., -1=declining, 0=stable, 1=improving)
      # @note Not documented by Strava API
      property 'direction'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents visibility settings for activity statistics.
    #
    # Controls which statistics are visible to others when viewing an activity.
    # This model is not documented in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::DetailedActivity
    #
    # @example Accessing stats visibility
    #   activity = client.activity(1234567890)
    #   if activity.stats_visibility
    #     activity.stats_visibility.each do |visibility|
    #       puts "#{visibility.type}: #{visibility.visibility}"
    #     end
    #   end
    #
    class StatsVisibility < Strava::Models::Response
      # @return [String, nil] Type of statistic (e.g., "heartrate", "power")
      # @note Not documented by Strava API
      property 'type'

      # @return [String, nil] Visibility setting (e.g., "everyone", "followers_only", "only_me")
      # @note Not documented by Strava API
      property 'visibility'
    end
  end
end

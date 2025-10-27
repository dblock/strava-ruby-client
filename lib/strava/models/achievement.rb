# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an achievement earned during a segment effort.
    #
    # Achievements include overall rank on a segment, yearly/monthly/weekly records,
    # and PR (personal record) designations. This model is not documented in the
    # official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::DetailedSegmentEffort
    #
    # @example Accessing achievements from a segment effort
    #   activity = client.activity(1234567890)
    #   activity.segment_efforts.each do |effort|
    #     effort.achievements.each do |achievement|
    #       puts "#{achievement.type}: Rank #{achievement.rank}"
    #     end
    #   end
    #
    class Achievement < Strava::Models::Response
      # @return [Integer, nil] Rank or position for this achievement (e.g., 1 for first place)
      # @note Not documented by Strava API
      property 'rank'

      # @return [String, nil] Type of achievement (e.g., "overall", "pr", "year_pr")
      # @note Not documented by Strava API
      property 'type'

      # @return [Integer, nil] Numeric identifier for the achievement type
      # @note Not documented by Strava API
      property 'type_id'
    end
  end
end

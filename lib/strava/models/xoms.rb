# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents segment leaderboard achievements (KOM/QOM).
    #
    # Contains information about King of the Mountain (KOM), Queen of the Mountain (QOM),
    # and overall segment records. This model is not documented in the official Strava
    # API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::DetailedActivity
    # @see Strava::Models::Destination
    #
    # @example Accessing XOM (KOM/QOM) information
    #   activity = client.activity(1234567890)
    #   if activity.xoms
    #     puts "KOM: #{activity.xoms.kom}"
    #     puts "QOM: #{activity.xoms.qom}"
    #     puts "Overall: #{activity.xoms.overall}"
    #     if activity.xoms.destination
    #       puts "Segment: #{activity.xoms.destination.name}"
    #     end
    #   end
    #
    class Xoms < Strava::Models::Response
      # @return [String, Integer, nil] King of the Mountain achievement data
      # @note Not documented by Strava API
      property 'kom'

      # @return [String, Integer, nil] Queen of the Mountain achievement data
      # @note Not documented by Strava API
      property 'qom'

      # @return [String, Integer, nil] Overall segment record data
      # @note Not documented by Strava API
      property 'overall'

      # @return [Destination, nil] Link to the segment where this achievement was earned
      # @note Not documented by Strava API
      property 'destination', transform_with: ->(v) { Strava::Models::Destination.new(v) }
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents Local Legend status on a segment.
    #
    # Local Legends are athletes with the most efforts on a segment in the last 90 days.
    # This model contains information about the current local legend for a segment.
    # This model is not documented in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::DetailedSegment
    #
    # @example Accessing local legend information
    #   segment = client.segment(1234567)
    #   if segment.local_legend
    #     legend = segment.local_legend
    #     puts "Local Legend: #{legend.title}"
    #     puts "Athlete ID: #{legend.athlete_id}"
    #     puts "#{legend.effort_description} (#{legend.effort_count} efforts)"
    #   end
    #
    class LocalLegend < Strava::Models::Response
      # @return [Integer, nil] ID of the athlete who is the local legend
      # @note Not documented by Strava API
      property 'athlete_id'

      # @return [String, nil] Title or name of the local legend
      # @note Not documented by Strava API
      property 'title'

      # @return [String, nil] URL to the athlete's profile picture
      # @note Not documented by Strava API
      property 'profile'

      # @return [String, nil] Description of the effort count (e.g., "X efforts in the last 90 days")
      # @note Not documented by Strava API
      property 'effort_description'

      # @return [Integer, nil] Number of efforts by this athlete in the qualifying period
      # @note Not documented by Strava API
      property 'effort_count'

      # @return [Hash, nil] Detailed effort count data
      # @note Not documented by Strava API
      property 'effort_counts'

      # @return [Destination, nil] Link to related resource
      # @note Not documented by Strava API
      property 'destination'
    end
  end
end

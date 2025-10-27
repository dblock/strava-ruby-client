# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an athlete's personal record (PR) on a segment.
    #
    # Contains information about the athlete's best effort on a particular segment,
    # including when it was achieved and how many times they've attempted the segment.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-SummaryPRSegmentEffort Strava API SummaryPRSegmentEffort reference
    # @see Strava::Models::SummarySegment
    # @see Strava::Models::DetailedSegmentEffort
    #
    # @example Accessing PR information from a segment
    #   segment = client.segment(1234567)
    #   if segment.athlete_pr_effort
    #     pr = segment.athlete_pr_effort
    #     puts "Your PR: #{pr.pr_elapsed_time} seconds"
    #     puts "Set on: #{pr.pr_date}"
    #     puts "Total attempts: #{pr.effort_count}"
    #   end
    #
    class SummaryPRSegmentEffort < Strava::Models::Response
      # @return [Integer, nil] Activity ID where the PR was achieved
      property 'pr_activity_id'

      # @return [Integer, nil] Elapsed time for the PR effort in seconds
      property 'pr_elapsed_time'

      # @return [Date, nil] Date when the PR was set
      property 'pr_date', transform_with: ->(v) { Date.parse(v) }

      # @return [Integer] Total number of times the athlete has attempted this segment
      property 'effort_count'

      # @return [String, nil] Visibility setting for the PR effort
      # @note Not documented by Strava API
      property 'pr_visibility'

      # @return [String, nil] Visibility setting for the activity containing the PR
      # @note Not documented by Strava API
      property 'pr_activity_visibility'
    end
  end
end

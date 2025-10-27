# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a comment on a Strava activity.
    #
    # Comments are text messages left by athletes on activities. Each comment
    # includes the text content, the athlete who made the comment, and timestamp.
    #
    # @example List activity comments
    #   comments = client.activity_comments(1234567890)
    #   comments.each do |comment|
    #     puts "#{comment.athlete.name}: #{comment.text}"
    #     puts "Posted at: #{comment.created_at}"
    #   end
    #
    # @see Strava::Api::Client#activity_comments
    #
    class Comment < Strava::Models::Response
      # @return [Integer] Comment ID
      property 'id'

      # @return [Integer] ID of the activity this comment is on
      property 'activity_id'

      # @return [String] The comment text
      property 'text'

      # @return [Time] When the comment was created
      property 'created_at', transform_with: ->(v) { Time.parse(v) }

      # @return [SummaryAthlete] The athlete who made the comment
      property 'athlete', transform_with: ->(v) { Strava::Models::SummaryAthlete.new(v) }

      # @note Undocumented in official API
      # @return [Integer, nil] Associated post ID
      property 'post_id'

      # @note Undocumented in official API
      # @return [Integer, nil] Resource state indicator
      property 'resource_state'

      # @note Undocumented in official API
      # @return [Hash, nil] Metadata about @mentions in the comment
      property 'mentions_metadata'

      # @note Undocumented in official API
      # @return [Integer, nil] Number of reactions on this comment
      property 'reaction_count'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the authenticated athlete has reacted to this comment
      property 'has_reacted'
    end
  end
end

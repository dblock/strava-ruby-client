# frozen_string_literal: true

module Strava
  module Models
    class Comment < Strava::Models::Response
      property 'id'
      property 'activity_id'
      property 'text'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::SummaryAthlete.new(v) }
      # undocumented
      property 'post_id'
      property 'resource_state'
      property 'mentions_metadata'
      property 'reaction_count'
      property 'has_reacted'
    end
  end
end

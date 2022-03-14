# frozen_string_literal: true

module Strava
  module Models
    class Comment < Model
      property 'id'
      property 'activity_id'
      property 'resource_state'
      property 'text'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
    end
  end
end

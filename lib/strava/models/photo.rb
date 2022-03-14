# frozen_string_literal: true

module Strava
  module Models
    class Photo < Model
      property 'id'
      property 'unique_id'
      property 'urls'
      property 'source'
      property 'athlete_id'
      property 'activity_id'
      property 'activity_name'
      property 'resource_state'
      property 'caption'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'created_at_local', transform_with: ->(v) { Time.parse(v) }
      property 'uploaded_at', transform_with: ->(v) { Time.parse(v) }
      property 'sizes'
      property 'default_photo'
    end
  end
end

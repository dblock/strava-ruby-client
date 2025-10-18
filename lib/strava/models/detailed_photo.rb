# frozen_string_literal: true

module Strava
  module Models
    # Undocumented
    class DetailedPhoto < Strava::Models::Response
      property 'unique_id'
      property 'athlete_id'
      property 'activity_id'
      property 'activity_name'
      property 'post_id'
      property 'resource_state'
      property 'caption'
      property 'type'
      property 'source'
      property 'status'
      property 'uploaded_at', transform_with: ->(v) { Time.parse(v) }
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'created_at_local', transform_with: ->(v) { Time.parse(v) }
      property 'urls'
      property 'placeholder_image'
      property 'sizes'
      property 'default_photo'
      property 'cursor'
      property 'duration'
      property 'video_url'
      property 'location'
    end
  end
end

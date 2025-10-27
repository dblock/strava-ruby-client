# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a photo or video attached to an activity.
    #
    # Photos can be uploaded directly to Strava or linked from Instagram.
    # This model contains URLs to various sizes of the media, timestamps,
    # and metadata about the photo or video.
    #
    # Note: This is an undocumented Strava API endpoint.
    #
    # @example List activity photos
    #   photos = client.activity_photos(1234567890)
    #   photos.each do |photo|
    #     puts photo.caption if photo.caption
    #     puts "Uploaded: #{photo.uploaded_at}"
    #     puts "URL: #{photo.urls['0']}" if photo.urls
    #     puts "Video: #{photo.video_url}" if photo.video_url
    #   end
    #
    # @see Strava::Api::Client#activity_photos
    #
    class DetailedPhoto < Strava::Models::Response
      # @return [String] Unique identifier for the photo/video
      property 'unique_id'

      # @return [Integer] ID of the athlete who uploaded the photo
      property 'athlete_id'

      # @return [Integer] ID of the activity this photo is attached to
      property 'activity_id'

      # @return [String] Name of the activity
      property 'activity_name'

      # @return [Integer, nil] Post identifier if photo is from a social post
      property 'post_id'

      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [String, nil] Photo caption/description
      property 'caption'

      # @return [Integer] Type of media (1=photo, 2=video)
      property 'type'

      # @return [Integer] Source of the photo (1=native Strava upload, 2=Instagram)
      property 'source'

      # @return [String] Processing status
      property 'status'

      # @return [Time] When the photo was uploaded to Strava
      property 'uploaded_at', transform_with: ->(v) { Time.parse(v) }

      # @return [Time] When the photo was created/taken
      property 'created_at', transform_with: ->(v) { Time.parse(v) }

      # @return [Time] Local time when photo was created
      property 'created_at_local', transform_with: ->(v) { Time.parse(v) }

      # @return [Hash] Map of size keys to photo URLs (e.g., {"0" => "https://...", "1000" => "https://..."})
      property 'urls'

      # @return [String, nil] URL to placeholder/thumbnail image
      property 'placeholder_image'

      # @return [Hash] Map of size keys to dimensions [width, height]
      property 'sizes'

      # @return [Boolean] Whether this is the default/cover photo for the activity
      property 'default_photo'

      # @return [String, nil] Pagination cursor for photo listing
      property 'cursor'

      # @return [Float, nil] Duration in seconds (for videos)
      property 'duration'

      # @return [String, nil] Direct URL to video file
      property 'video_url'

      # @return [Array<Float>, nil] Geographic location [latitude, longitude] where photo was taken
      property 'location'
    end
  end
end

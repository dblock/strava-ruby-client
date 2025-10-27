# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents the primary photo reference in a photos summary.
    #
    # Contains identification and URL information for the primary photo
    # of an activity.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-PhotosSummary_primary Strava API PhotosSummary_primary reference
    # @see Strava::Models::PhotosSummary
    #
    # @example Accessing primary photo URLs
    #   activity = client.activity(1234567890)
    #   if activity.photos&.primary
    #     photo = activity.photos.primary
    #     puts "Photo ID: #{photo.id}"
    #     puts "Source: #{photo.source}"
    #     puts "URLs: #{photo.urls}"
    #   end
    #
    class PhotosSummaryPrimary < Strava::Models::Response
      # @return [Integer, nil] Unique identifier for the photo
      property 'id'

      # @return [Integer] Source of the photo (1=native Strava upload, 2=Instagram)
      property 'source'

      # @return [String] Unique identifier string for the photo
      property 'unique_id'

      # @return [Hash] Hash containing URLs to different sizes of the photo
      property 'urls'

      # @return [Integer, nil] Type of media (1=photo, 2=video)
      # @note Not documented by Strava API
      property 'media_type'
    end
  end
end

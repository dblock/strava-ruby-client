# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents detailed photo information for an activity.
    #
    # Contains the primary photo and total photo count for an activity.
    # This model is not documented in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::DetailedActivity
    # @see Strava::Models::DetailedPhoto
    #
    # @example Accessing activity photos
    #   activity = client.activity(1234567890)
    #   if activity.photos
    #     puts "Total photos: #{activity.photos.count}"
    #     if activity.photos.primary
    #       puts "Primary photo ID: #{activity.photos.primary.id}"
    #     end
    #   end
    #
    class DetailedPhotos < Strava::Models::Response
      # @return [Photo, nil] The primary/featured photo for the activity
      # @note Not documented by Strava API
      property 'primary', transform_with: ->(v) { Strava::Models::Photo.new(v) }

      # @return [Boolean, nil] Whether to use the primary photo for display
      # @note Not documented by Strava API
      property 'use_primary_photo'

      # @return [Integer, nil] Total number of photos attached to the activity
      # @note Not documented by Strava API
      property 'count'

      # Hashie >= 6 does not define property readers that conflict with existing methods.
      if Gem::Version.new(Hashie::VERSION) >= Gem::Version.new('6.0')
        def count
          self['count']
        end
      end
    end
  end
end

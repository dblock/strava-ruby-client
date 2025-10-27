# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents summary photo information for an activity.
    #
    # Contains basic information about photos attached to an activity,
    # including the count and primary photo reference.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-PhotosSummary Strava API PhotosSummary reference
    # @see Strava::Models::PhotosSummaryPrimary
    # @see Strava::Models::SummaryActivity
    #
    # @example Accessing activity photo summary
    #   activity = client.activity(1234567890)
    #   if activity.photos && activity.photos.count > 0
    #     puts "This activity has #{activity.photos.count} photo(s)"
    #     if activity.photos.primary
    #       puts "Primary photo: #{activity.photos.primary.urls}"
    #     end
    #   end
    #
    class PhotosSummary < Strava::Models::Response
      # @return [Integer] Total number of photos attached to the activity
      property 'count'

      # @return [Boolean, nil] Whether to use the primary photo for display
      # @note Not documented by Strava API
      property 'use_primary_photo'

      # @return [PhotosSummaryPrimary, nil] The primary/featured photo reference
      property 'primary', transform_with: ->(v) { Strava::Models::PhotosSummaryPrimary.new(v) }
    end
  end
end

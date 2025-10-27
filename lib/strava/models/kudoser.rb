# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a user who gave kudos to an activity.
    #
    # Kudos are a way for athletes to show appreciation for each other's activities.
    # This model is not documented in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Api::Client#activity_kudos
    #
    # @example Listing kudos for an activity
    #   kudos = client.activity_kudos(1234567890)
    #   kudos.each do |kudoser|
    #     puts "#{kudoser.display_name} gave kudos"
    #     puts "  Avatar: #{kudoser.avatar_url}"
    #   end
    #
    class Kudoser < Strava::Models::Response
      # @return [String, nil] URL to the athlete's profile page
      # @note Not documented by Strava API
      property 'destination_url'

      # @return [String, nil] Display name of the athlete who gave kudos
      # @note Not documented by Strava API
      property 'display_name'

      # @return [String, nil] URL to the athlete's avatar image
      # @note Not documented by Strava API
      property 'avatar_url'

      # @return [Boolean, nil] Whether to show the athlete's name
      # @note Not documented by Strava API
      property 'show_name'
    end
  end
end

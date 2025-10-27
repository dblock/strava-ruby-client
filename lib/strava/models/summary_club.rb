# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents summary information about a Strava club.
    #
    # Contains basic club information without detailed membership data.
    # This is typically returned when listing athlete's clubs or as a
    # reference within other models.
    #
    # @example List athlete's clubs
    #   clubs = client.athlete_clubs
    #   clubs.each do |club|
    #     puts "#{club.name} - #{club.member_count} members"
    #     puts club.strava_url
    #   end
    #
    # @see DetailedClub
    # @see https://developers.strava.com/docs/reference/#api-models-SummaryClub
    #
    class SummaryClub < Strava::Models::Response
      # @return [Integer] Club identifier
      property 'id'

      # @return [Integer] Resource state indicator (1=meta, 2=summary, 3=detailed)
      property 'resource_state'

      # @return [String] Club name
      property 'name'

      # @return [String] URL to medium-sized profile picture
      property 'profile_medium'

      # @return [String] URL to club cover photo
      property 'cover_photo'

      # @return [String] URL to smaller club cover photo
      property 'cover_photo_small'

      # @return [String] Primary sport type (e.g., "cycling", "running", "other")
      property 'sport_type'

      # @return [Array<String>] List of activity types the club supports
      property 'activity_types'

      # @return [String] City where club is located
      property 'city'

      # @return [String] State/province where club is located
      property 'state'

      # @return [String] Country where club is located
      property 'country'

      # @return [Boolean] Whether club is private
      property 'private'

      # @return [Integer] Number of club members
      property 'member_count'

      # @return [Boolean] Whether club is featured by Strava
      property 'featured'

      # @return [Boolean] Whether club is verified by Strava
      property 'verified'

      # @return [String] Club URL slug
      property 'url'

      # @return [String] URL to full-sized profile picture
      property 'profile'

      # @return [String] Icon representing the activity types
      property 'activity_types_icon'

      # @return [Array<Integer>] Dimensions of cover photo [width, height]
      property 'dimensions'

      # @return [String] Localized sport type string
      property 'localized_sport_type'

      #
      # Returns the Strava web URL for this club.
      #
      # @return [String] Full URL to view the club on Strava.com
      #
      def strava_url
        "https://www.strava.com/clubs/#{url || id}"
      end
    end
  end
end

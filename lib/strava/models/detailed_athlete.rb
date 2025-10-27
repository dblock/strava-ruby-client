# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents detailed information about a Strava athlete.
    #
    # Contains comprehensive profile information including personal details,
    # preferences, gear, clubs, and social connections. This model is typically
    # returned when accessing the authenticated athlete's own profile.
    #
    # @example Get athlete profile
    #   athlete = client.athlete
    #   puts athlete.name
    #   puts "Location: #{athlete.city}, #{athlete.state}, #{athlete.country}"
    #   puts "Premium: #{athlete.premium}"
    #   puts "Weight: #{athlete.weight}kg"
    #   puts athlete.strava_url
    #
    # @see SummaryAthlete
    # @see https://developers.strava.com/docs/reference/#api-models-DetailedAthlete
    #
    class DetailedAthlete < Strava::Models::Response
      # @return [Integer] Athlete ID
      property 'id'

      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [String] First name
      property 'firstname'

      # @return [String] Last name
      property 'lastname'

      # @return [String, nil] URL to medium-sized profile picture
      property 'profile_medium'

      # @return [String, nil] URL to full-sized profile picture
      property 'profile'

      # @return [String, nil] City
      property 'city'

      # @return [String, nil] State or province
      property 'state'

      # @return [String, nil] Country
      property 'country'

      # @return [String] Sex ('M' for male, 'F' for female)
      property 'sex'

      # @return [Boolean] Whether the athlete has a premium subscription
      property 'premium'

      # @return [Boolean] Whether the athlete has a Summit subscription
      property 'summit'

      # @return [Time] When the athlete account was created
      property 'created_at', transform_with: ->(v) { Time.parse(v) }

      # @return [Time] When the athlete account was last updated
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }

      # @return [Integer] Number of followers
      property 'follower_count'

      # @return [Integer] Number of friends (mutual follows)
      property 'friend_count'

      # @return [String] Preferred measurement system ('feet' or 'meters')
      property 'measurement_preference'

      # @return [Integer, nil] Functional Threshold Power in watts
      property 'ftp'

      # @return [Float, nil] Weight in kilograms
      property 'weight'

      # @return [Array<SummaryClub>] Clubs the athlete belongs to
      property 'clubs', transform_with: ->(v) { v.map { |r| Strava::Models::SummaryClub.new(r) } }

      # @return [Array<SummaryGear>] Bikes registered to this athlete
      property 'bikes', transform_with: ->(v) { v.map { |r| Strava::Models::SummaryGear.new(r) } }

      # @return [Array<SummaryGear>] Shoes registered to this athlete
      property 'shoes', transform_with: ->(v) { v.map { |r| Strava::Models::SummaryGear.new(r) } }

      # @note Undocumented in official API
      # @return [String, nil] Username/vanity URL
      property 'username'

      # @note Undocumented in official API
      # @return [String, nil] Athlete bio/description
      property 'bio'

      # @note Undocumented in official API
      # @return [Integer, nil] Badge type identifier
      property 'badge_type_id'

      # @note Undocumented in official API
      # @return [String, nil] Relationship status with authenticated athlete ('pending', 'accepted', 'blocked', or nil)
      property 'friend'

      # @note Undocumented in official API
      # @return [String, nil] Follower relationship status
      property 'follower'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether this athlete is blocked by the authenticated athlete
      property 'blocked'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the authenticated athlete can follow this athlete
      property 'can_follow'

      # @note Undocumented in official API
      # @return [Integer, nil] Number of mutual friends with the authenticated athlete
      property 'mutual_friend_count'

      # @note Undocumented in official API
      # @return [Integer, nil] Athlete type identifier (0 = Cyclist, 1 = Runner)
      property 'athlete_type'

      # @note Undocumented in official API
      # @return [String, nil] Preferred date format
      property 'date_preference'

      # @note Undocumented in official API
      # @return [Integer, nil] Number of clubs where athlete can post
      property 'postable_clubs_count'

      #
      # Returns the athlete's full name.
      #
      # @return [String, nil] Full name combining firstname and lastname, or nil if neither exists
      #
      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end

      #
      # Returns the Strava web URL for this athlete's profile.
      #
      # @return [String] Full URL to view the athlete on Strava.com
      #
      def strava_url
        "https://www.strava.com/athletes/#{username || id}"
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents summary information about a Strava athlete.
    #
    # Contains basic profile information about an athlete. This is typically returned
    # when listing kudoers, commenters, or other athletes associated with activities,
    # rather than the full {DetailedAthlete} information.
    #
    # @example Access athlete who kudoed an activity
    #   kudoers = client.activity_kudos(1234567890)
    #   kudoers.each do |athlete|
    #     puts "#{athlete.name} from #{athlete.city}"
    #     puts athlete.strava_url
    #   end
    #
    # @see DetailedAthlete
    # @see https://developers.strava.com/docs/reference/#api-models-SummaryAthlete
    #
    class SummaryAthlete < Strava::Models::Response
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
        "https://www.strava.com/athletes/#{id}"
      end
    end
  end
end

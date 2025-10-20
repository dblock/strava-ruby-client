# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-ClubAthlete
    class ClubAthlete < Strava::Models::Response
      property 'resource_state'
      property 'firstname'
      property 'lastname'
      property 'member'
      property 'admin'
      property 'owner'
      # undocumented
      property 'membership'

      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end

      def strava_url
        "https://www.strava.com/athletes/#{username || id}"
      end
    end
  end
end

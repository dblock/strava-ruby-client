# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-SummaryAthlete
    class SummaryAthlete < Strava::Models::Response
      property 'id'
      property 'resource_state'
      property 'firstname'
      property 'lastname'
      property 'profile_medium'
      property 'profile'
      property 'city'
      property 'state'
      property 'country'
      property 'sex'
      property 'premium'
      property 'summit'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }

      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end

      def strava_url
        "https://www.strava.com/athletes/#{username || id}"
      end
    end
  end
end

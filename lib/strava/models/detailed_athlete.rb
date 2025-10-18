# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-DetailedAthlete
    class DetailedAthlete < Strava::Models::Response
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
      property 'follower_count'
      property 'friend_count'
      property 'measurement_preference'
      property 'ftp'
      property 'weight'
      property 'clubs', transform_with: ->(v) { v.map { |r| Strava::Models::SummaryClub.new(r) } }
      property 'bikes', transform_with: ->(v) { v.map { |r| Strava::Models::SummaryGear.new(r) } }
      property 'shoes', transform_with: ->(v) { v.map { |r| Strava::Models::SummaryGear.new(r) } }
      # undocumented
      property 'username'
      property 'bio'
      property 'badge_type_id'
      property 'friend'
      property 'follower'
      property 'blocked'
      property 'can_follow'
      property 'mutual_friend_count'
      property 'athlete_type'
      property 'date_preference'
      property 'postable_clubs_count'

      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end

      def strava_url
        "https://www.strava.com/athletes/#{username || id}"
      end
    end
  end
end

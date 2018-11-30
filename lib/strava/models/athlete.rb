module Strava
  module Models
    class Athlete < Model
      property 'id'
      property 'username'
      property 'resource_state'
      property 'firstname'
      property 'lastname'
      property 'city'
      property 'state'
      property 'country'
      property 'sex'
      property 'premium'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      property 'badge_type_id'
      property 'profile'
      property 'profile_medium'
      property 'email'
      property 'follower'
      property 'friend'
      property 'summit'
      property 'follower_count'
      property 'friend_count'
      property 'mutual_friend_count'
      property 'athlete_type'
      property 'date_preference'
      property 'measurement_preference'
      property 'clubs', transform_with: ->(v) { v.map { |r| Strava::Models::Club.new(r) } }
      property 'weight'
      property 'bikes', transform_with: ->(v) { v.map { |r| Strava::Models::Gear.new(r) } }
      property 'shoes', transform_with: ->(v) { v.map { |r| Strava::Models::Gear.new(r) } }

      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end

      def strava_url
        "https://www.strava.com/athletes/#{username || id}"
      end
    end
  end
end

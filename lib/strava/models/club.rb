module Strava
  module Models
    class Club < Model
      property 'id'
      property 'resource_state'
      property 'name'
      property 'profile_medium'
      property 'profile'
      property 'cover_photo'
      property 'cover_photo_small'
      property 'sport_type'
      property 'city'
      property 'state'
      property 'country'
      property 'private'
      property 'member_count'
      property 'featured'
      property 'verified'
      property 'url'
      property 'membership'
      property 'admin'
      property 'owner'
      property 'description'
      property 'club_type'
      property 'following_count'

      def strava_url
        "https://www.strava.com/clubs/#{url || id}"
      end
    end
  end
end

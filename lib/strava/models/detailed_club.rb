# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-DetailedClub
    class DetailedClub < Strava::Models::Response
      property 'id'
      property 'resource_state'
      property 'name'
      property 'profile_medium'
      property 'cover_photo'
      property 'cover_photo_small'
      property 'sport_type'
      property 'activity_types'
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
      property 'club_type'
      property 'following_count'
      # undocumented
      property 'profile'
      property 'activity_types_icon'
      property 'dimensions'
      property 'localized_sport_type'
      property 'description'
      property 'website'

      def strava_url
        "https://www.strava.com/clubs/#{url || id}"
      end
    end
  end
end

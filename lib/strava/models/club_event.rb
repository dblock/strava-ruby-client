# frozen_string_literal: true

module Strava
  module Models
    # Unodcumented
    class ClubEvent < Strava::Models::Response
      property 'id'
      property 'resource_state'
      property 'title'
      property 'description'
      property 'club_id'
      property 'club', transform_with: ->(c) { Strava::Models::SummaryClub.new(c) }
      property 'organizing_athlete', transform_with: ->(oa) { Strava::Models::SummaryAthlete.new(oa) }
      property 'activity_type'
      property 'created_at', transform_with: ->(v) { Time.parse(v) if v&.length&.positive? }
      property 'route_id'
      property 'route', transform_with: ->(r) { Strava::Models::Route.new(r) }
      property 'women_only'
      property 'private'
      property 'skill_levels'
      property 'terrain'
      property 'upcoming_occurrences', transform_with: ->(upcoming) { upcoming.map { |o| Time.parse(o) } }
      property 'zone'
      property 'address'
      property 'joined'
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      def strava_url
        "https://www.strava.com/clubs/#{club_id}/group_events/#{id}"
      end
    end
  end
end

module Strava
  module Models
    class ClubEvent < Model
      property 'id'
      property 'resource_state'
      property 'title'
      property 'club_id'
      property 'club', transform_with: ->(c) { Strava::Model::Club.new(c) }
      property 'organizing_athlete', transform_with: ->(oa) { Strava::Models::Athlete.new(oa) }
      property 'activity_type'
      property 'created_at'
      property 'route_id'
      property 'route', transform_with: ->(r) { Strava::Model::Route.new(r) }
      property 'women_only'
      property 'private'
      property 'skill_levels'
      property 'terrain'
      property 'upcoming_occurences'
      property 'zone'
      property 'address'
      property 'start_latlng'

      def strava_url
        "https://www.strava.com/clubs/#{club_id}/group_events/#{id}"
      end
    end
  end
end

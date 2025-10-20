# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-SummaryActivity
    class SummaryActivity < Strava::Models::Response
      property 'id'
      property 'external_id'
      property 'upload_id'
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }
      property 'name'
      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::TotalElevationGain
      property 'elev_high'
      property 'elev_low'
      include Mixins::SportType
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      include Mixins::StartDateLocal
      property 'timezone'
      property 'start_latlng'
      property 'end_latlng'
      property 'achievement_count'
      property 'kudos_count'
      property 'comment_count'
      property 'athlete_count'
      property 'photo_count'
      property 'total_photo_count'
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'trainer'
      property 'commute'
      property 'manual'
      property 'private'
      property 'flagged'
      property 'workout_type'
      property 'upload_id_str'
      property 'average_speed'
      property 'max_speed'
      property 'has_kudoed'
      property 'hide_from_home'
      property 'gear_id'
      property 'kilojoules'
      property 'average_watts'
      property 'device_watts'
      property 'max_watts'
      property 'weighted_average_watts'
      # undocumented
      property 'resource_state'

      def strava_url
        "https://www.strava.com/activities/#{id}"
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-DetailedActivity
    class DetailedActivity < Strava::Models::Response
      property 'id'
      property 'external_id'
      property 'upload_id'
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }
      property 'name'
      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::AverageSpeed
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
      property 'description'
      property 'photos', transform_with: ->(v) { Strava::Models::PhotosSummary.new(v) }
      property 'gear', transform_with: ->(v) { Strava::Models::SummaryGear.new(v) }
      property 'calories'
      property 'segment_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::DetailedSegmentEffort.new(r) } }
      property 'device_name'
      property 'embed_token'
      property 'splits_metric', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }
      property 'splits_standard', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }
      property 'laps', transform_with: ->(v) { v.map { |r| Strava::Models::Lap.new(r) } }
      property 'best_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::DetailedSegmentEffort.new(r) } }
      # undocumented
      property 'resource_state'
      property 'utc_offset'
      property 'location_city'
      property 'location_state'
      property 'location_country'
      property 'visibility'
      property 'average_temp'
      property 'has_heartrate'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'heartrate_opt_out'
      property 'display_hide_heartrate_option'
      property 'from_accepted_tag'
      property 'pr_count'
      property 'suffer_score'
      property 'perceived_exertion'
      property 'prefer_perceived_exertion'
      property 'stats_visibility', transform_with: ->(v) { v.map { |r| Strava::Models::StatsVisibility.new(r) } }
      property 'available_zones'
      property 'similar_activities', transform_with: ->(v) { Strava::Models::SimilarActivities.new(v) }
      property 'average_cadence'
      property 'highlighted_kudosers'
      property 'segment_leaderboard_opt_out'
      property 'leaderboard_opt_out'

      def strava_url
        "https://www.strava.com/activities/#{id}"
      end
    end
  end
end

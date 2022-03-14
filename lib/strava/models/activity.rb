# frozen_string_literal: true

module Strava
  module Models
    class Activity < Model
      include Mixins::Time
      include Mixins::Distance
      include Mixins::Elevation
      include Mixins::StartDateLocal

      property 'id'
      property 'resource_state'
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'name'
      property 'description'
      property 'type'
      property 'workout_type'
      property 'id'
      property 'external_id'
      property 'upload_id'
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'timezone'
      property 'utc_offset'
      property 'start_latlng'
      property 'end_latlng'
      property 'location_city'
      property 'location_state'
      property 'location_country'
      property 'start_latitude'
      property 'start_longitude'
      property 'achievement_count'
      property 'kudos_count'
      property 'comment_count'
      property 'athlete_count'
      property 'photo_count'
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'trainer'
      property 'commute'
      property 'manual'
      property 'private'
      property 'visibility'
      property 'flagged'
      property 'gear_id'
      property 'from_accepted_tag'
      property 'average_speed'
      property 'max_speed'
      property 'has_heartrate'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'heartrate_opt_out'
      property 'display_hide_heartrate_option'
      property 'elev_high'
      property 'elev_low'
      property 'pr_count'
      property 'total_photo_count'
      property 'has_kudoed'
      property 'suffer_score'
      property 'calories'
      property 'segment_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::SegmentEffort.new(r) } }
      property 'best_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::SegmentEffort.new(r) } }
      property 'photos', transform_with: ->(v) { Strava::Models::Photos.new(v) }
      property 'similar_activities', transform_with: ->(v) { Strava::Models::SimilarActivities.new(v) }
      property 'embed_token'
      property 'available_zones'
      property 'splits_metric', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }
      property 'splits_standard', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }
      property 'laps', transform_with: ->(v) { v.map { |r| Strava::Models::Lap.new(r) } }
      property 'gear', transform_with: ->(v) { Strava::Models::Gear.new(v) }
      property 'device_name'
      property 'average_cadence'
      property 'average_temp'
      property 'average_watts'
      property 'weighted_average_watts'
      property 'kilojoules'
      property 'device_watts'
      property 'max_watts'
      property 'highlighted_kudosers', transform_with: ->(v) { v.map { |r| Strava::Models::Kudoser.new(r) } }
      property 'segment_leaderboard_opt_out'
      property 'leaderboard_opt_out'

      def distance_s
        if type == 'Swim'
          distance_in_meters_s
        else
          distance_in_kilometers_s
        end
      end

      def pace_s
        case type
        when 'Swim'
          pace_per_100_meters_s
        else
          pace_per_kilometer_s
        end
      end

      def strava_url
        "https://www.strava.com/activities/#{id}"
      end

      def type_emoji
        case type
        when 'Run', 'VirtualRun' then '🏃'
        when 'Ride', 'EBikeRide', 'VirtualRide' then '🚴'
        when 'Swim' then '🏊'
        when 'Walk' then '🚶'
        when 'AlpineSki' then '⛷️'
        when 'BackcountrySki' then '🎿️'
        # when 'Canoeing' then ''
        # when 'Crossfit' then ''
        # when 'Elliptical' then ''
        # when 'Hike' then ''
        when 'IceSkate' then '⛸️'
        # when 'InlineSkate' then ''
        # when 'Kayaking' then ''
        # when 'Kitesurf' then ''
        # when 'NordicSki' then ''
        when 'RockClimbing' then '🧗'
        when 'RollerSki' then ''
        when 'Rowing' then '🚣'
        when 'Snowboard' then '🏂'
        # when 'Snowshoe' then ''
        # when 'StairStepper' then ''
        # when 'StandUpPaddling' then ''
        when 'Surfing' then '🏄'
        when 'WeightTraining' then '🏋️'
        # when 'Windsurf' then ''
        when 'Wheelchair' then '♿'
          # when 'Workout' then ''
          # when 'Yoga'' then ''
        end
      end
    end
  end
end

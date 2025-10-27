# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a detailed Strava activity.
    #
    # A detailed activity contains all information about a single workout, ride, run,
    # or other athletic pursuit recorded on Strava. This includes basic information
    # (name, type, date), metrics (distance, time, elevation), maps, segments, photos,
    # and social interactions (kudos, comments).
    #
    # This model includes several mixins that provide helper methods for formatting data:
    # * {Mixins::Distance} - distance_s, distance_in_miles, etc.
    # * {Mixins::MovingTime} - moving_time_in_hours_s, etc.
    # * {Mixins::ElapsedTime} - elapsed_time_in_hours_s, etc.
    # * {Mixins::AverageSpeed} - average_speed_s, pace_s, etc.
    # * {Mixins::TotalElevationGain} - total_elevation_gain_s, etc.
    # * {Mixins::SportType} - sport_type_emoji
    #
    # @example Get and display activity details
    #   activity = client.activity(1234567890)
    #   puts activity.name
    #   puts "Distance: #{activity.distance_s}"
    #   puts "Time: #{activity.moving_time_in_hours_s}"
    #   puts "Pace: #{activity.pace_s}"
    #   puts "Elevation: #{activity.total_elevation_gain_s}"
    #   puts "URL: #{activity.strava_url}"
    #
    # @see https://developers.strava.com/docs/reference/#api-models-DetailedActivity
    #
    class DetailedActivity < Strava::Models::Response
      # @return [Integer] Activity ID
      property 'id'

      # @return [String, nil] External ID from the original upload source
      property 'external_id'

      # @return [Integer, nil] Upload ID
      property 'upload_id'

      # @return [MetaAthlete] The athlete who performed the activity
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }

      # @return [String] Activity name
      property 'name'

      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::AverageSpeed
      include Mixins::TotalElevationGain

      # @return [Float, nil] Highest elevation in meters
      property 'elev_high'

      # @return [Float, nil] Lowest elevation in meters
      property 'elev_low'

      include Mixins::SportType

      # @return [Time] Start date and time (UTC)
      property 'start_date', transform_with: ->(v) { Time.parse(v) }

      include Mixins::StartDateLocal

      # @return [String] Timezone in which the activity was recorded (e.g., '(GMT-08:00) America/Los_Angeles')
      property 'timezone'

      # @return [LatLng, nil] Starting coordinates [latitude, longitude]
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [LatLng, nil] Ending coordinates [latitude, longitude]
      property 'end_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [Integer] Number of achievements (segment PRs, CRs, etc.)
      property 'achievement_count'

      # @return [Integer] Number of kudos received
      property 'kudos_count'

      # @return [Integer] Number of comments
      property 'comment_count'

      # @return [Integer] Number of athletes who participated (group activities)
      property 'athlete_count'

      # @return [Integer] Number of photos attached
      property 'photo_count'

      # @return [Integer] Total number of photos including Instagram
      property 'total_photo_count'

      # @return [Map] Activity map with polyline data
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }

      # @return [Boolean] Whether this activity was on a stationary trainer
      property 'trainer'

      # @return [Boolean] Whether this activity was a commute
      property 'commute'

      # @return [Boolean] Whether this activity was manually entered
      property 'manual'

      # @return [Boolean] Whether this activity is set to private
      property 'private'

      # @return [Boolean] Whether this activity has been flagged
      property 'flagged'

      # @return [Integer, nil] Workout type (e.g., 10 = Race, 11 = Workout)
      property 'workout_type'

      # @return [String, nil] Upload ID as a string
      property 'upload_id_str'

      # @return [Float] Average speed in meters per second
      property 'average_speed'

      # @return [Float] Maximum speed in meters per second
      property 'max_speed'

      # @return [Boolean] Whether the authenticated athlete has kudoed this activity
      property 'has_kudoed'

      # @return [Boolean] Whether to hide this activity from the home feed
      property 'hide_from_home'

      # @return [String, nil] Gear (bike/shoes) ID used for this activity
      property 'gear_id'

      # @return [Float, nil] Kilojoules of energy expended
      property 'kilojoules'

      # @return [Float, nil] Average power in watts
      property 'average_watts'

      # @return [Boolean, nil] Whether the watts are from a power meter (true) or estimated (false)
      property 'device_watts'

      # @return [Integer, nil] Maximum power in watts
      property 'max_watts'

      # @return [Integer, nil] Weighted average power in watts
      property 'weighted_average_watts'

      # @return [String, nil] Activity description
      property 'description'

      # @return [PhotosSummary, nil] Summary of activity photos
      property 'photos', transform_with: ->(v) { Strava::Models::PhotosSummary.new(v) }

      # @return [SummaryGear, nil] The gear (bike/shoes) used for this activity
      property 'gear', transform_with: ->(v) { Strava::Models::SummaryGear.new(v) }

      # @return [Float, nil] Estimated calories burned
      property 'calories'

      # @return [Array<DetailedSegmentEffort>] All segment efforts for this activity
      property 'segment_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::DetailedSegmentEffort.new(r) } }

      # @return [String, nil] Name of the device used to record the activity
      property 'device_name'

      # @return [String, nil] Embed token for the activity
      property 'embed_token'

      # @return [Array<Split>] Metric splits (per kilometer)
      property 'splits_metric', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }

      # @return [Array<Split>] Standard/imperial splits (per mile)
      property 'splits_standard', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }

      # @return [Array<Lap>] Laps for the activity
      property 'laps', transform_with: ->(v) { v.map { |r| Strava::Models::Lap.new(r) } }

      # @return [Array<DetailedSegmentEffort>] Best efforts (e.g., 400m, 1/2 mile, 1k, etc.)
      property 'best_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::DetailedSegmentEffort.new(r) } }

      # @note Undocumented in official API
      # @return [Integer, nil] Resource state indicator
      property 'resource_state'

      # @note Undocumented in official API
      # @return [Float, nil] UTC offset in seconds
      property 'utc_offset'

      # @note Undocumented in official API
      # @return [String, nil] City where the activity took place
      property 'location_city'

      # @note Undocumented in official API
      # @return [String, nil] State/province where the activity took place
      property 'location_state'

      # @note Undocumented in official API
      # @return [String, nil] Country where the activity took place
      property 'location_country'

      # @note Undocumented in official API
      # @return [String, nil] Activity visibility setting (e.g., 'everyone', 'followers_only')
      property 'visibility'

      # @note Undocumented in official API
      # @return [Float, nil] Average temperature during the activity in Celsius
      property 'average_temp'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the activity has heart rate data
      property 'has_heartrate'

      # @note Undocumented in official API
      # @return [Float, nil] Average heart rate in beats per minute
      property 'average_heartrate'

      # @note Undocumented in official API
      # @return [Float, nil] Maximum heart rate in beats per minute
      property 'max_heartrate'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the athlete has opted out of heart rate display
      property 'heartrate_opt_out'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether to display the hide heart rate option
      property 'display_hide_heartrate_option'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the activity was created from an accepted tag
      property 'from_accepted_tag'

      # @note Undocumented in official API
      # @return [Integer, nil] Number of personal records achieved in this activity
      property 'pr_count'

      # @note Undocumented in official API
      # @return [Integer, nil] Relative effort score (suffer score)
      property 'suffer_score'

      # @note Undocumented in official API
      # @return [Integer, nil] Athlete's perceived exertion rating
      property 'perceived_exertion'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether to prefer perceived exertion over calculated metrics
      property 'prefer_perceived_exertion'

      # @note Undocumented in official API
      # @return [Array<StatsVisibility>, nil] Stats visibility settings
      property 'stats_visibility', transform_with: ->(v) { v.map { |r| Strava::Models::StatsVisibility.new(r) } }

      # @note Undocumented in official API
      # @return [Array<String>, nil] List of available zone types for this activity
      property 'available_zones'

      # @note Undocumented in official API
      # @return [SimilarActivities, nil] Information about similar activities
      property 'similar_activities', transform_with: ->(v) { Strava::Models::SimilarActivities.new(v) }

      # @note Undocumented in official API
      # @return [Float, nil] Average cadence (RPM for cycling, steps/minute for running)
      property 'average_cadence'

      # @note Undocumented in official API
      # @return [Array, nil] List of highlighted athletes who gave kudos
      property 'highlighted_kudosers'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the athlete has opted out of segment leaderboards
      property 'segment_leaderboard_opt_out'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the athlete has opted out of all leaderboards
      property 'leaderboard_opt_out'

      #
      # Returns the Strava web URL for this activity.
      #
      # @return [String] Full URL to view the activity on Strava.com
      #
      # @example
      #   activity = client.activity(1234567890)
      #   puts activity.strava_url
      #   # => "https://www.strava.com/activities/1234567890"
      #
      def strava_url
        "https://www.strava.com/activities/#{id}"
      end
    end
  end
end

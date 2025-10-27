# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a summary view of a Strava activity.
    #
    # A summary activity contains the most important information about an activity
    # without the detailed segments, splits, and other extended data found in
    # {DetailedActivity}. This model is typically returned when listing activities
    # or when full details are not needed.
    #
    # Includes helper mixins for formatting distance, time, elevation, speed, and sport type.
    #
    # @example List and display activities
    #   activities = client.athlete_activities(per_page: 10)
    #   activities.each do |activity|
    #     puts "#{activity.name} - #{activity.distance_s} in #{activity.moving_time_in_hours_s}"
    #     puts activity.strava_url
    #   end
    #
    # @see DetailedActivity
    # @see https://developers.strava.com/docs/reference/#api-models-SummaryActivity
    #
    class SummaryActivity < Strava::Models::Response
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
      include Mixins::TotalElevationGain

      # @return [Float, nil] Highest elevation in meters
      property 'elev_high'

      # @return [Float, nil] Lowest elevation in meters
      property 'elev_low'

      include Mixins::SportType

      # @return [Time] Start date and time (UTC)
      property 'start_date', transform_with: ->(v) { Time.parse(v) }

      include Mixins::StartDateLocal

      # @return [String] Timezone in which the activity was recorded
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

      # @note Undocumented in official API
      # @return [Integer, nil] Resource state indicator
      property 'resource_state'

      # @note Undocumented in official API
      # @return [String, nil] Activity visibility setting (e.g., 'everyone', 'followers_only')
      property 'visibility'

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
      # @return [Float, nil] Average cadence (RPM for cycling, steps/minute for running)
      property 'average_cadence'

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

      #
      # Returns the Strava web URL for this activity.
      #
      # @return [String] Full URL to view the activity on Strava.com
      #
      def strava_url
        "https://www.strava.com/activities/#{id}"
      end
    end
  end
end

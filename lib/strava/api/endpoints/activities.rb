# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava activities.
      #
      # Activities represent workouts, rides, runs, and other athletic pursuits recorded on Strava.
      # This module provides methods for creating, retrieving, updating, and listing activities,
      # as well as accessing related data like comments, kudos, laps, and zones.
      #
      # @see https://developers.strava.com/docs/reference/#api-Activities
      #
      module Activities
        #
        # Create a manual activity.
        #
        # Creates a new manual activity for an athlete. Requires write access.
        #
        # @param [Hash] options Activity attributes
        # @option options [String] :name Activity name (required)
        # @option options [String] :sport_type Activity type (required, e.g., 'Run', 'Ride', 'Swim')
        # @option options [Time, String] :start_date_local Local start date and time (required)
        # @option options [Integer] :elapsed_time Activity duration in seconds (required)
        # @option options [String] :description Activity description
        # @option options [Float] :distance Distance in meters
        # @option options [Boolean] :trainer Whether activity was on a trainer
        # @option options [Boolean] :commute Whether activity was a commute
        #
        # @return [Strava::Models::DetailedActivity] The created activity
        #
        # @example
        #   activity = client.create_activity(
        #     name: 'Morning Run',
        #     sport_type: 'Run',
        #     start_date_local: Time.now,
        #     elapsed_time: 3600,
        #     distance: 10000,
        #     description: 'Easy recovery run'
        #   )
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-createActivity
        #
        def create_activity(options = {})
          Strava::Models::DetailedActivity.new(post('activities', options))
        end

        #
        # Get detailed information about a specific activity.
        #
        # Returns the given activity that is owned by the authenticated athlete.
        # Includes all activity details such as splits, laps, segment efforts, and photos.
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Additional options
        # @option options [Boolean] :include_all_efforts Include all segment efforts
        #
        # @return [Strava::Models::DetailedActivity] The activity
        #
        # @example Get activity by ID
        #   activity = client.activity(1234567890)
        #   puts activity.name
        #   puts activity.distance_s
        #
        # @example Get activity with options hash
        #   activity = client.activity(id: 1234567890, include_all_efforts: true)
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-getActivityById
        #
        def activity(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::DetailedActivity.new(get("activities/#{id}", options))
        end

        #
        # List comments for an activity.
        #
        # Returns the comments on the given activity. Supports cursor-based pagination.
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Pagination options
        # @option options [Integer] :page_size Number of items per page (default: 30)
        # @option options [String] :after_cursor Cursor for pagination
        # @option options [Integer] :limit Maximum number of items to return
        # @option options [Integer] :per_page (Deprecated) Use :page_size instead
        #
        # @yield [Strava::Models::Comment] Yields each comment if block given
        # @return [Array<Strava::Models::Comment>] Array of comments
        #
        # @example Get all comments
        #   comments = client.activity_comments(1234567890)
        #
        # @example Paginate through comments
        #   client.activity_comments(1234567890, page_size: 50) do |comment|
        #     puts "#{comment.athlete.username}: #{comment.text}"
        #   end
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-getCommentsByActivityId
        #
        def activity_comments(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate_with_cursor "activities/#{id}/comments", options, Strava::Models::Comment, &block
        end

        #
        # List photos for an activity.
        #
        # Returns the photos on the given activity. This is an undocumented Strava API endpoint.
        # By default, retrieves full-size photos (5000px).
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Pagination options
        # @option options [Integer] :size Photo size in pixels (default: 5000 for full size)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page (default: 30)
        #
        # @yield [Strava::Models::DetailedPhoto] Yields each photo if block given
        # @return [Array<Strava::Models::DetailedPhoto>] Array of photos
        #
        # @example Get all photos
        #   photos = client.activity_photos(1234567890)
        #   photos.each { |photo| puts photo.urls }
        #
        # @example Get specific size
        #   photos = client.activity_photos(1234567890, size: 1920)
        #
        def activity_photos(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          options[:size] = 5000 unless options[:size] # to retrieve full size photos
          paginate "activities/#{id}/photos", options, Strava::Models::DetailedPhoto, &block
        end

        #
        # List athletes who kudoed an activity.
        #
        # Returns the athletes who kudoed an activity identified by an identifier.
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Pagination options
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page (default: 30)
        #
        # @yield [Strava::Models::SummaryAthlete] Yields each athlete if block given
        # @return [Array<Strava::Models::SummaryAthlete>] Array of athletes
        #
        # @example Get all kudoers
        #   kudoers = client.activity_kudos(1234567890)
        #   kudoers.each { |athlete| puts athlete.username }
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-getKudoersByActivityId
        #
        def activity_kudos(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "activities/#{id}/kudos", options, Strava::Models::SummaryAthlete, &block
        end

        #
        # List laps for an activity.
        #
        # Returns the laps of an activity identified by an identifier.
        # Laps are split segments either created manually or auto-generated.
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Additional options
        #
        # @return [Array<Strava::Models::Lap>] Array of laps
        #
        # @example Get activity laps
        #   laps = client.activity_laps(1234567890)
        #   laps.each { |lap| puts "#{lap.name}: #{lap.distance_s}" }
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-getLapsByActivityId
        #
        def activity_laps(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get("activities/#{id}/laps", options).map do |row|
            Strava::Models::Lap.new(row)
          end
        end

        #
        # List activities for the authenticated athlete.
        #
        # Returns the currently logged-in athlete's activities. Supports pagination and time-based filtering.
        # Activities are returned in descending order by start date.
        #
        # @param [Hash] options Pagination and filtering options
        # @option options [Time, Integer] :before Epoch timestamp or Time object for filtering activities before this time
        # @option options [Time, Integer] :after Epoch timestamp or Time object for filtering activities after this time
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page (default: 30)
        # @option options [Integer] :limit Maximum number of items to return
        #
        # @yield [Strava::Models::SummaryActivity] Yields each activity if block given
        # @return [Array<Strava::Models::SummaryActivity>] Array of activities
        #
        # @example Get recent activities
        #   activities = client.athlete_activities(per_page: 10)
        #
        # @example Get activities with time filter
        #   activities = client.athlete_activities(
        #     after: Time.now - 7.days,
        #     per_page: 50
        #   )
        #
        # @example Paginate through all activities
        #   client.athlete_activities(per_page: 100) do |activity|
        #     puts "#{activity.name}: #{activity.distance_s}"
        #   end
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-getLoggedInAthleteActivities
        #
        def athlete_activities(options = {}, &block)
          options = options.dup if options.key?(:after) || options.key?(:before)
          options[:after] = options[:after].to_i if options[:after]
          options[:before] = options[:before].to_i if options[:before]
          paginate 'athlete/activities', options, Strava::Models::SummaryActivity, &block
        end

        #
        # Get zones for an activity.
        #
        # Returns the zones of a given activity. Summit feature required.
        # Zones include heart rate and power zones with distribution buckets.
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Additional options
        #
        # @return [Array<Strava::Models::ActivityZone>] Array of activity zones
        #
        # @example Get activity zones
        #   zones = client.activity_zones(1234567890)
        #   zones.each do |zone|
        #     puts "Type: #{zone.type}"
        #     zone.distribution_buckets.each { |bucket| puts "#{bucket.min}-#{bucket.max}: #{bucket.time}s" }
        #   end
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-getZonesByActivityId
        #
        def activity_zones(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get("activities/#{id}/zones", options).map do |row|
            Strava::Models::ActivityZone.new(row)
          end
        end

        #
        # Update an activity.
        #
        # Updates the given activity that is owned by the authenticated athlete.
        # Requires write access.
        #
        # @param [Integer, Hash] id_or_options Activity ID or options hash with :id key
        # @param [Hash] options Activity attributes to update
        # @option options [Boolean] :commute Whether this activity is a commute
        # @option options [Boolean] :trainer Whether this activity was recorded on a training machine
        # @option options [String] :description Activity description
        # @option options [String] :name Activity name
        # @option options [String] :sport_type Activity type (e.g., 'Run', 'Ride')
        # @option options [String] :gear_id Equipment ID (specify "none" to clear gear)
        #
        # @return [Strava::Models::DetailedActivity] The updated activity
        #
        # @example Update activity name and description
        #   activity = client.update_activity(
        #     id: 1234567890,
        #     name: 'Updated Activity Name',
        #     description: 'New description'
        #   )
        #
        # @example Mark as commute
        #   activity = client.update_activity(1234567890, commute: true)
        #
        # @see https://developers.strava.com/docs/reference/#api-Activities-updateActivityById
        #
        def update_activity(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::DetailedActivity.new(put("activities/#{id}", options))
        end
      end
    end
  end
end

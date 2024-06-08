# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      module Activities
        #
        # Create an activity.
        #
        def create_activity(options = {})
          Strava::Models::Activity.new(post('activities', options))
        end

        #
        # Get activity.
        #
        # @option options [String] :id
        #   Activity id.
        #
        def activity(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Activity.new(get("activities/#{id}", options))
        end

        #
        # List activity comments.
        #
        # @option options [String] :id
        #   Activity id.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def activity_comments(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "activities/#{id}/comments", options, Strava::Models::Comment, &block
        end

        #
        # List activity photos.
        #
        # @option options [String] :id
        #   Activity id.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def activity_photos(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "activities/#{id}/photos?size=7000", options, Strava::Models::Photo, &block
        end

        #
        # List activity kudoers.
        #
        # @option options [String] :id
        #   Activity id.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def activity_kudos(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "activities/#{id}/kudos", options, Strava::Models::Athlete, &block
        end

        #
        # Get activity laps.
        #
        # @option options [String] :id
        #   Activity id.
        #
        def activity_laps(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get("activities/#{id}/laps", options).map do |row|
            Strava::Models::Lap.new(row)
          end
        end

        #
        # List logged-in athlete activities.
        #
        # @option options [Integer] :before
        #   An epoch timestamp to use for filtering activities that have taken place before a certain time.
        # @option options [Integer] :after
        #   An epoch timestamp to use for filtering activities that have taken place after a certain time.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def athlete_activities(options = {}, &block)
          options = options.dup if options.key?(:after) || options.key?(:before)
          options[:after] = options[:after].to_i if options[:after]
          options[:before] = options[:before].to_i if options[:before]
          paginate 'athlete/activities', options, Strava::Models::Activity, &block
        end

        #
        # Get activity zones.
        #
        # @option options [String] :id
        #   Activity id.
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
        # @option options [String] :id
        #   Activity id.
        # @option options [Boolean] :commute
        #   Whether this activity is a commute.
        # @option options [Boolean] :trainer
        #   Whether this activity was recorded on a training machine.
        # @option options [String] :description
        #   The description of the activity.
        # @option options [String] :name
        #   The name of the activity.
        # @option options [String] :sport_type
        #   Activity type.
        # @option options [String] :gear_id
        #   Identifier for the gear associated with the activity. Specifying "none" clears gear from activity.
        #
        def update_activity(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Activity.new(put("activities/#{id}", options))
        end
      end
    end
  end
end

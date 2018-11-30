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
        def activity(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::Activity.new(get("activities/#{options[:id]}", options.except(:id)))
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
        def activity_comments(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "activities/#{options[:id]}/comments", options.except(:id), Strava::Models::Comment, &block
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
        def activity_kudos(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "activities/#{options[:id]}/kudos", options.except(:id), Strava::Models::Athlete, &block
        end

        #
        # Get activity laps.
        #
        # @option options [String] :id
        #   Activity id.
        #
        def activity_laps(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          get("activities/#{options[:id]}/laps", options.except(:id)).map do |row|
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
          paginate 'athlete/activities', options, Strava::Models::Activity, &block
        end

        #
        # Get activity zones.
        #
        # @option options [String] :id
        #   Activity id.
        #
        def activity_zones(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          get("activities/#{options[:id]}/zones", options.except(:id)).map do |row|
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
        # @option options [String] :type
        #   Activity type.
        # @option options [String] :gear_id
        #   Identifier for the gear associated with the activity. Specifying "none" clears gear from activity.
        #
        def update_activity(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::Activity.new(put("activities/#{options[:id]}", options.except(:id)))
        end
      end
    end
  end
end

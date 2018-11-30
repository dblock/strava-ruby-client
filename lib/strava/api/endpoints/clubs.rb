module Strava
  module Api
    module Endpoints
      module Clubs
        #
        # List club activities.
        #
        # @option options [String] :id
        #   Club id.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def club_activities(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "clubs/#{options[:id]}/activities", options.except(:id), Strava::Models::Activity, &block
        end

        #
        # List club administrators.
        #
        # @option options [String] :id
        #   Club id.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def club_admins(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "clubs/#{options[:id]}/admins", options.except(:id), Strava::Models::Athlete, &block
        end

        #
        # Get club.
        #
        # @option options [String] :id
        #   Club id.
        #
        def club(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::Club.new(get("clubs/#{options[:id]}", options.except(:id)))
        end

        #
        # List club members.
        #
        # @option options [String] :id
        #   Club id.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def club_members(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "clubs/#{options[:id]}/members", options.except(:id), Strava::Models::Athlete, &block
        end

        #
        # List logged-in athlete clubs.
        #
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def athlete_clubs(options = {}, &block)
          paginate 'athlete/clubs', options, Strava::Models::Club, &block
        end
      end
    end
  end
end

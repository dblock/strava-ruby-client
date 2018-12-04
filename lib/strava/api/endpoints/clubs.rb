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
        def club_activities(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/activities", options, Strava::Models::Activity, &block
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
        def club_admins(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/admins", options, Strava::Models::ClubAdmin, &block
        end

        #
        # Get club.
        #
        # @option options [String] :id
        #   Club id.
        #
        def club(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Club.new(get("clubs/#{id}", options))
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
        def club_members(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/members", options, Strava::Models::ClubMember, &block
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

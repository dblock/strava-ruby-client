# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava clubs.
      #
      # Clubs represent groups of athletes on Strava. Club API endpoints allow
      # you to retrieve club information and view recent club events.
      #
      # Note: the Club Activities, Club Members, and Club Admins endpoints were
      # removed by Strava on September 1, 2026.
      #
      # @see https://developers.strava.com/docs/reference/#api-Clubs
      # @see https://developers.strava.com/docs/changelog/
      #
      module Clubs
        #
        # List club / group events.
        #
        # @param id_or_options [String, Integer, Hash] Either a club ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        def club_events(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/group_events", options, Strava::Models::ClubEvent, &block
        end

        #
        # Get club.
        #
        # @param id_or_options [String, Integer, Hash] Either a club ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        def club(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::DetailedClub.new(get("clubs/#{id}", options))
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
          paginate 'athlete/clubs', options, Strava::Models::SummaryClub, &block
        end
      end
    end
  end
end

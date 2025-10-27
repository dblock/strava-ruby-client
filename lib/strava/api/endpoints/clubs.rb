# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava clubs.
      #
      # Clubs represent groups of athletes on Strava. Club API endpoints allow
      # you to retrieve club information, list club members and administrators,
      # and view recent club activities and events.
      #
      # @see https://developers.strava.com/docs/reference/#api-Clubs
      #
      module Clubs
        #
        # List club activities.
        #
        # @param id_or_options [String, Integer, Hash] Either a club ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        # @example With ID and options as separate arguments
        #   client.club_activities('12345', per_page: 10)
        #
        # @example With ID in options hash
        #   client.club_activities(id: '12345', per_page: 10)
        #
        def club_activities(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/activities", options, Strava::Models::ClubActivity, &block
        end

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
        # List club administrators.
        #
        # @param id_or_options [String, Integer, Hash] Either a club ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        def club_admins(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/admins", options, Strava::Models::ClubAthlete, &block
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
        # List club members.
        #
        # @param id_or_options [String, Integer, Hash] Either a club ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        def club_members(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "clubs/#{id}/members", options, Strava::Models::ClubAthlete, &block
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

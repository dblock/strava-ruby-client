# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava routes.
      #
      # Routes are manually-created paths on Strava that can be used for planning.
      # Routes can be exported in GPX or TCX format and can include waypoints,
      # elevation data, and other metadata.
      #
      # @see https://developers.strava.com/docs/reference/#api-Routes
      #
      module Routes
        #
        # Returns a GPX file of the route.
        #
        # @param id_or_options [String, Integer, Hash] Either a route ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        def export_route_gpx(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get("routes/#{id}/export_gpx", options).response
        end

        #
        # Returns a TCX file of the route.
        #
        # @param id_or_options [String, Integer, Hash] Either a route ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        def export_route_tcx(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get("routes/#{id}/export_tcx", options).response
        end

        #
        # Returns a route using its identifier.
        #
        # @param id_or_options [String, Integer, Hash] Either a route ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        def route(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Route.new(get("routes/#{id}", options))
        end

        #
        # Returns a list of the routes created by the authenticated athlete using their athlete ID.
        #
        # @param id_or_options [String, Integer, Hash] Either an athlete ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        def athlete_routes(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "athletes/#{id}/routes", options, Strava::Models::Route, &block
        end
      end
    end
  end
end

module Strava
  module Api
    module Endpoints
      module Routes
        #
        # Returns a GPX file of the route.
        #
        # @option options [String] :id
        #   Route id.
        #
        def export_route_gpx(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get "routes/#{id}/export_gpx", options
        end

        #
        # Returns a TCS file of the route.
        #
        # @option options [String] :id
        #   Route id.
        #
        def export_route_tcx(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          get "routes/#{id}/export_tcx", options
        end

        #
        # Returns a route using its identifier.
        #
        # @option options [String] :id
        #   Route id.
        #
        def route(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Route.new(get("routes/#{id}", options))
        end

        #
        # Returns a list of the routes created by the authenticated athlete using their athlete ID.
        #
        # @option options [Integer] :id
        #   The identifier of the athlete.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def athlete_routes(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "athletes/#{id}/routes", options, Strava::Models::Route, &block
        end
      end
    end
  end
end

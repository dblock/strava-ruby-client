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
        def export_route_gpx(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          get "routes/#{options[:id]}/export_gpx", options.except(:id)
        end

        #
        # Returns a TCS file of the route.
        #
        # @option options [String] :id
        #   Route id.
        #
        def export_route_tcx(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          get "routes/#{options[:id]}/export_tcx", options.except(:id)
        end

        #
        # Returns a route using its identifier.
        #
        # @option options [String] :id
        #   Route id.
        #
        def route(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::Route.new(get("routes/#{options[:id]}", options.except(:id)))
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
        def athlete_routes(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "athletes/#{options[:id]}/routes", options.except(:id), Strava::Models::Route, &block
        end
      end
    end
  end
end

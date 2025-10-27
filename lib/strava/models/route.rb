# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a Strava route.
    #
    # Routes are planned courses that athletes can follow for activities.
    # They include map data, waypoints, and estimated moving time. Routes can
    # be exported as GPX or TCX files for use with GPS devices.
    #
    # Includes helper mixins for formatting distance, elevation gain, and time.
    #
    # @example Get and display route information
    #   route = client.route(1234567)
    #   puts route.name
    #   puts route.description
    #   puts "Distance: #{route.distance_s}"
    #   puts "Elevation gain: #{route.elevation_gain_s}"
    #   puts "Estimated time: #{route.estimated_moving_time_in_hours_s}"
    #
    # @example Export route as GPX
    #   gpx_data = client.export_route_gpx(route.id)
    #   File.write('route.gpx', gpx_data)
    #
    # @see Strava::Api::Client#route
    # @see Strava::Api::Client#export_route_gpx
    # @see Strava::Api::Client#export_route_tcx
    # @see https://developers.strava.com/docs/reference/#api-models-Route
    #
    class Route < Strava::Models::Response
      # @return [SummaryAthlete] The athlete who created this route
      property 'athlete', transform_with: ->(v) { Strava::Models::SummaryAthlete.new(v) }

      # @return [String, nil] Route description
      property 'description'

      include Mixins::Distance
      include Mixins::ElevationGain

      # @return [Integer] Route ID
      property 'id'

      # @return [String] Route ID as a string
      property 'id_str'

      # @return [Map] Route map with polyline data
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }

      # @return [String] Route name
      property 'name'

      # @return [Boolean] Whether this route is private
      property 'private'

      # @return [Boolean] Whether this route has been starred by the authenticated athlete
      property 'starred'

      # @return [Time] Timestamp for the route
      property 'timestamp', transform_with: ->(v) { Time.at(v) }

      # @return [Integer] Route type (1 = Ride, 2 = Run)
      property 'type'

      # @return [Integer] Route sub-type for additional categorization
      property 'sub_type'

      # @return [Time] When the route was created
      property 'created_at', transform_with: ->(v) { Time.parse(v) }

      # @return [Time] When the route was last updated
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }

      include Mixins::EstimatedMovingTime

      # @return [Array<SummarySegment>] Segments along this route
      property 'segments', transform_with: ->(v) { v.map { |r| Strava::Models::SummarySegment.new(r) } }

      # @return [Array<Waypoint>] Waypoints along this route
      property 'waypoints', transform_with: ->(v) { v.map { |r| Strava::Models::Waypoint.new(r) } }

      # @note Undocumented in official API
      # @return [Hash, nil] URLs to map images at various sizes
      property 'map_urls'

      # @note Undocumented in official API
      # @return [Integer, nil] Resource state indicator
      property 'resource_state'
    end
  end
end

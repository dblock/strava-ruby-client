# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a waypoint on a route.
    #
    # Waypoints are markers along a route that can indicate points of interest,
    # turns, or other significant locations. They include GPS coordinates and
    # descriptive information.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-Waypoint Strava API Waypoint reference
    # @see Strava::Models::Route
    # @see Strava::Models::LatLng
    #
    # @example Accessing route waypoints
    #   route = client.route(1234567)
    #   route.waypoints.each do |waypoint|
    #     puts "#{waypoint.title}: #{waypoint.description}"
    #     puts "  Location: #{waypoint.latlng.lat}, #{waypoint.latlng.lng}"
    #     puts "  Distance into route: #{waypoint.distance_into_route}m"
    #     puts "  Categories: #{waypoint.categories.join(', ')}"
    #   end
    #
    class Waypoint < Strava::Models::Response
      # @return [LatLng] GPS coordinates of the waypoint
      property 'latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [LatLng, nil] Target GPS coordinates (may differ from latlng for snapped waypoints)
      property 'target_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [Array<String>] Categories or types for this waypoint (e.g., ["water", "rest"])
      property 'categories'

      # @return [String] Title or name of the waypoint
      property 'title'

      # @return [String, nil] Detailed description of the waypoint
      property 'description'

      # @return [Float] Distance from the start of the route to this waypoint in meters
      property 'distance_into_route'
    end
  end
end

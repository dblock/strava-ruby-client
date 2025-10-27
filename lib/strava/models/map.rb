# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a map with polyline data for an activity, route, or segment.
    #
    # Maps contain encoded polyline data that represents the geographic path.
    # The polyline format uses Google's encoded polyline algorithm which can
    # be decoded using libraries like the 'polylines' gem.
    #
    # @example Decode and use polyline data
    #   require 'polylines'
    #
    #   activity = client.activity(1234567890)
    #   map = activity.map
    #
    #   # Decode the summary polyline
    #   decoded = Polylines::Decoder.decode_polyline(map.summary_polyline)
    #   start_point = decoded.first  # [latitude, longitude]
    #   end_point = decoded.last
    #
    #   # Use with Google Maps Static API
    #   url = "https://maps.googleapis.com/maps/api/staticmap?" \
    #         "path=enc:#{CGI.escape(map.summary_polyline)}&size=800x800"
    #
    # @see https://developers.google.com/maps/documentation/utilities/polylinealgorithm
    #
    class Map < Strava::Models::Response
      # @return [String] Map identifier
      property 'id'

      # @return [String] Google polyline encoding of the route (lower resolution)
      property 'summary_polyline'

      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [String] Google polyline encoding of the route (higher resolution)
      property 'polyline'
    end
  end
end

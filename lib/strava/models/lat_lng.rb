# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents geographic coordinates (latitude/longitude).
    #
    # This is a helper class for working with geographic coordinates in Strava data.
    # Coordinates are stored as an array [latitude, longitude] and can be accessed
    # via helper methods or array syntax.
    #
    # @example Accessing coordinates
    #   activity = client.activity(1234567890)
    #   start = activity.start_latlng
    #   puts "Latitude: #{start.lat}"
    #   puts "Longitude: #{start.lng}"
    #   puts "Array: #{start.to_a.inspect}"  # [40.7128, -74.0060]
    #
    # @example Creating coordinates
    #   coords = Strava::Models::LatLng.new([40.7128, -74.0060])
    #   coords.lat  # => 40.7128
    #   coords.lng  # => -74.0060
    #
    class LatLng
      # @return [Array<Float>] Coordinates as [latitude, longitude]
      attr_accessor :latlng

      #
      # Initialize with coordinates.
      #
      # @param latlng [Array<Float>, nil] Coordinates as [latitude, longitude]
      #
      def initialize(latlng = nil)
        @latlng = latlng
      end

      # @return [Float, nil] Latitude
      def lat
        @latlng[0]
      end

      # @return [Float, nil] Longitude
      def lng
        @latlng[1]
      end

      # @param value [Float] Latitude value
      def lat=(value)
        @latlng ||= [nil, nil]
        @latlng[0] = value
      end

      # @param value [Float] Longitude value
      def lng=(value)
        @latlng ||= [nil, nil]
        @latlng[1] = value
      end

      #
      # Compare with another LatLng or Array.
      #
      # @param other [LatLng, Array] Object to compare with
      # @return [Boolean] true if coordinates are equal
      #
      def ==(other)
        case other
        when LatLng
          @latlng == other.to_a
        when Array
          @latlng == other
        else
          false
        end
      end

      # @return [Array<Float>] Coordinates as array [latitude, longitude]
      def to_a
        @latlng
      end

      alias to_h to_a
      alias as_json to_a

      # @return [String] JSON representation
      def to_json(*args)
        as_json.to_json(args)
      end

      # @return [String] String representation of coordinates
      def inspect
        @latlng.inspect
      end

      alias to_s inspect
    end
  end
end

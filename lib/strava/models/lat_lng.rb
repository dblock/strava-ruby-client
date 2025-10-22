# frozen_string_literal: true

module Strava
  module Models
    class LatLng
      attr_accessor :latlng

      def lat
        @latlng[0]
      end

      def lng
        @latlng[1]
      end

      def lat=(value)
        @latlng ||= [nil, nil]
        @latlng[0] = value
      end

      def lng=(value)
        @latlng ||= [nil, nil]
        @latlng[1] = value
      end

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

      def to_a
        @latlng
      end

      alias to_h to_a
      alias as_json to_a

      def to_json(*args)
        as_json.to_json(args)
      end

      def inspect
        @latlng.inspect
      end

      alias to_s inspect

      def initialize(latlng = nil)
        @latlng = latlng
      end
    end
  end
end

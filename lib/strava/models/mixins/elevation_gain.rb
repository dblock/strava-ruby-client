# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides elevation gain conversion and formatting methods.
      #
      # Elevation gain represents the total upward elevation change during an activity.
      # This mixin adds the elevation_gain property and helper methods to convert
      # and format it in meters or feet.
      #
      # @example Using elevation gain helpers
      #   route = client.route(1234567)
      #   puts route.elevation_gain              # => 450.5 (meters)
      #   puts route.elevation_gain_s            # => "450.5m"
      #   puts route.elevation_gain_in_feet_s    # => "1478.0ft"
      #
      module ElevationGain
        extend ActiveSupport::Concern

        included do
          # @return [Float] Elevation gain in meters
          property 'elevation_gain'
        end

        #
        # Returns elevation gain in feet.
        #
        # @return [Float] Elevation gain in feet
        #
        def elevation_gain_in_feet
          elevation_gain * 3.28084
        end

        #
        # Returns elevation gain in meters (same as elevation_gain).
        #
        # @return [Float] Elevation gain in meters
        #
        def elevation_gain_in_meters
          elevation_gain
        end

        #
        # Returns formatted elevation gain in meters.
        #
        # @return [String, nil] Formatted elevation (e.g., "450.5m")
        #
        def elevation_gain_in_meters_s
          return if elevation_gain.nil?

          format('%gm', format('%.1f', elevation_gain_in_meters))
        end

        #
        # Returns formatted elevation gain in feet.
        #
        # @return [String, nil] Formatted elevation (e.g., "1478.0ft")
        #
        def elevation_gain_in_feet_s
          return if elevation_gain.nil?

          format('%gft', format('%.1f', elevation_gain_in_feet))
        end

        #
        # Returns default formatted elevation gain (meters).
        #
        # @return [String, nil] Formatted elevation (e.g., "450.5m")
        #
        def elevation_gain_s
          elevation_gain_in_meters_s
        end
      end
    end
  end
end

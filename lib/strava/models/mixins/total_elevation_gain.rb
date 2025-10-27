# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides total elevation gain conversion and formatting methods.
      #
      # Total elevation gain represents the cumulative upward elevation change
      # during an activity. This is distinct from elevation_gain - this property
      # is typically used for activities while elevation_gain is used for routes.
      #
      # This mixin adds the total_elevation_gain property and helper methods to
      # convert and format it in meters or feet.
      #
      # @example Using total elevation gain helpers
      #   activity = client.activity(1234567890)
      #   puts activity.total_elevation_gain              # => 725.3 (meters)
      #   puts activity.total_elevation_gain_s            # => "725.3m"
      #   puts activity.total_elevation_gain_in_feet_s    # => "2379.6ft"
      #
      module TotalElevationGain
        extend ActiveSupport::Concern

        included do
          # @return [Float] Total elevation gain in meters
          property 'total_elevation_gain'
        end

        #
        # Returns total elevation gain in feet.
        #
        # @return [Float] Total elevation gain in feet
        #
        def total_elevation_gain_in_feet
          total_elevation_gain * 3.28084
        end

        #
        # Returns total elevation gain in meters (same as total_elevation_gain).
        #
        # @return [Float] Total elevation gain in meters
        #
        def total_elevation_gain_in_meters
          total_elevation_gain
        end

        #
        # Returns formatted total elevation gain in meters.
        #
        # @return [String, nil] Formatted elevation (e.g., "725.3m")
        #
        def total_elevation_gain_in_meters_s
          return if total_elevation_gain.nil?

          format('%gm', format('%.1f', total_elevation_gain_in_meters))
        end

        #
        # Returns formatted total elevation gain in feet.
        #
        # @return [String, nil] Formatted elevation (e.g., "2379.6ft")
        #
        def total_elevation_gain_in_feet_s
          return if total_elevation_gain.nil?

          format('%gft', format('%.1f', total_elevation_gain_in_feet))
        end

        #
        # Returns default formatted total elevation gain (meters).
        #
        # @return [String, nil] Formatted elevation (e.g., "725.3m")
        #
        def total_elevation_gain_s
          total_elevation_gain_in_meters_s
        end
      end
    end
  end
end

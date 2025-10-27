# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides elevation difference conversion and formatting methods.
      #
      # Elevation difference represents the net elevation change (can be positive
      # or negative) for a split or segment. This differs from elevation_gain which
      # only counts upward movement.
      #
      # This mixin adds the elevation_difference property and helper methods to
      # convert and format it in meters or feet.
      #
      # @example Using elevation difference helpers
      #   split = activity.splits_metric.first
      #   puts split.elevation_difference              # => -15.2 (meters, downhill)
      #   puts split.elevation_difference_s            # => "-15.2m"
      #   puts split.elevation_difference_in_feet_s    # => "-49.9ft"
      #
      module ElevationDifference
        extend ActiveSupport::Concern

        included do
          # @return [Float] Net elevation difference in meters (positive = uphill, negative = downhill)
          property 'elevation_difference'
        end

        #
        # Returns elevation difference in feet.
        #
        # @return [Float] Elevation difference in feet
        #
        def elevation_difference_in_feet
          elevation_difference * 3.28084
        end

        #
        # Returns elevation difference in meters (same as elevation_difference).
        #
        # @return [Float] Elevation difference in meters
        #
        def elevation_difference_in_meters
          elevation_difference
        end

        #
        # Returns formatted elevation difference in meters.
        #
        # @return [String, nil] Formatted elevation (e.g., "15.2m" or "-15.2m")
        #
        def elevation_difference_in_meters_s
          return if elevation_difference.nil?

          format('%gm', format('%.1f', elevation_difference_in_meters))
        end

        #
        # Returns formatted elevation difference in feet.
        #
        # @return [String, nil] Formatted elevation (e.g., "49.9ft" or "-49.9ft")
        #
        def elevation_difference_in_feet_s
          return if elevation_difference.nil?

          format('%gft', format('%.1f', elevation_difference_in_feet))
        end

        #
        # Returns default formatted elevation difference (meters).
        #
        # @return [String, nil] Formatted elevation (e.g., "15.2m" or "-15.2m")
        #
        def elevation_difference_s
          elevation_difference_in_meters_s
        end
      end
    end
  end
end

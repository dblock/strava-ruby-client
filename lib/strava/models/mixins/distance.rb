# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides distance conversion and formatting methods.
      #
      # This mixin is included in models that have a distance property, such as
      # activities, laps, segments, and routes. It provides helper methods to
      # convert and format distances in various units.
      #
      # @example Using distance helpers
      #   activity = client.activity(1234567890)
      #   puts activity.distance              # => 10000.0 (meters)
      #   puts activity.distance_s            # => "10.0km"
      #   puts activity.distance_in_miles_s   # => "6.21mi"
      #   puts activity.distance_in_yards_s   # => "10936.1yd"
      #
      module Distance
        extend ActiveSupport::Concern

        included do
          # @return [Float] Distance in meters
          property 'distance'
        end

        # @return [Float] Distance in meters
        def distance_in_meters
          distance
        end

        # @return [Float] Distance in feet
        def distance_in_feet
          distance * 3.28084
        end

        # @return [Float] Distance in miles
        def distance_in_miles
          distance_in_meters * 0.00062137
        end

        # @return [String, nil] Formatted distance in miles (e.g., "6.21mi")
        def distance_in_miles_s
          return unless distance&.positive?

          format('%gmi', format('%.2f', distance_in_miles))
        end

        # @return [Float] Distance in yards
        def distance_in_yards
          distance_in_meters * 1.09361
        end

        # @return [String, nil] Formatted distance in yards (e.g., "10936.1yd")
        def distance_in_yards_s
          return unless distance&.positive?

          format('%gyd', format('%.1f', distance_in_yards))
        end

        # @return [String, nil] Formatted distance in meters (e.g., "10000m")
        def distance_in_meters_s
          return unless distance&.positive?

          format('%gm', format('%d', distance_in_meters))
        end

        # @return [Float] Distance in kilometers
        def distance_in_kilometers
          distance_in_meters / 1000
        end

        # @return [String, nil] Formatted distance in kilometers (e.g., "10.0km")
        def distance_in_kilometers_s
          return unless distance&.positive?

          format('%gkm', format('%.2f', distance_in_kilometers))
        end

        # @return [String, nil] Default formatted distance (same as distance_in_kilometers_s)
        def distance_s
          distance_in_kilometers_s
        end
      end
    end
  end
end

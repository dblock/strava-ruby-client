# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides average speed and pace conversion methods.
      #
      # This mixin adds the average_speed property (stored in meters per second)
      # and provides helper methods to convert it to various speed and pace formats.
      # Pace is the inverse of speed (time per distance) and is commonly used for running.
      #
      # @example Using speed and pace helpers
      #   activity = client.activity(1234567890)
      #   puts activity.average_speed                    # => 3.5 (m/s)
      #   puts activity.average_speed_s                  # => "12.6km/h"
      #   puts activity.average_speed_miles_per_hour_s   # => "7.8mph"
      #   puts activity.pace_per_kilometer_s             # => "4m45s/km"
      #   puts activity.pace_per_mile_s                  # => "7m40s/mi"
      #
      module AverageSpeed
        extend ActiveSupport::Concern

        included do
          # @return [Float] Average speed in meters per second
          property 'average_speed'
        end

        #
        # Returns average speed in meters per second (same as average_speed).
        #
        # @return [Float] Average speed in m/s
        #
        # @note Always in meters per second, even in imperial splits
        #
        def average_speed_meters_per_second
          average_speed
        end

        #
        # Returns pace per mile.
        #
        # @return [String, nil] Pace formatted as "Xm%Ys/mi" (e.g., "7m30s/mi")
        #
        def pace_per_mile_s
          convert_meters_per_second_to_pace average_speed, :mi
        end

        #
        # Returns pace per 100 yards (swimming).
        #
        # @return [String, nil] Pace formatted as "XmYs/100yd"
        #
        def pace_per_100_yards_s
          convert_meters_per_second_to_pace average_speed, :'100yd'
        end

        #
        # Returns pace per 100 meters (swimming).
        #
        # @return [String, nil] Pace formatted as "XmYs/100m"
        #
        def pace_per_100_meters_s
          convert_meters_per_second_to_pace average_speed, :'100m'
        end

        #
        # Returns pace per kilometer.
        #
        # @return [String, nil] Pace formatted as "XmYs/km" (e.g., "4m30s/km")
        #
        def pace_per_kilometer_s
          convert_meters_per_second_to_pace average_speed, :km
        end

        #
        # Returns average speed in kilometers per hour.
        #
        # @return [String, nil] Speed formatted as "X.Xkm/h"
        #
        def average_speed_kilometer_per_hour_s
          return unless average_speed&.positive?

          format('%.1fkm/h', average_speed * 3.6)
        end

        #
        # Returns average speed in miles per hour.
        #
        # @return [String, nil] Speed formatted as "X.Xmph"
        #
        def average_speed_miles_per_hour_s
          return unless average_speed&.positive?

          format('%.1fmph', average_speed * 2.23694)
        end

        #
        # Returns default formatted average speed (kilometers per hour).
        #
        # @return [String, nil] Speed formatted as "X.Xkm/h"
        #
        def average_speed_s
          average_speed_kilometer_per_hour_s
        end

        #
        # Returns default formatted pace (per kilometer).
        #
        # @return [String, nil] Pace formatted as "XmYs/km"
        #
        def pace_s
          pace_per_kilometer_s
        end

        private

        #
        # Converts speed in meters per second to pace (time per distance).
        #
        # Pace is calculated as the inverse of speed. For example, running at 3.33 m/s
        # equals a 5:00/km pace (1000m / 3.33m/s = 300 seconds = 5 minutes).
        #
        # @param speed [Float, nil] Speed in meters per second
        # @param unit [Symbol] Unit for pace calculation (:mi, :km, :'100yd', :'100m')
        # @return [String, nil] Formatted pace string or nil if speed is nil/zero
        #
        # @see http://yizeng.me/2017/02/25/convert-speed-to-pace-programmatically-using-ruby
        #
        # @api private
        #
        def convert_meters_per_second_to_pace(speed, unit = :mi)
          return unless speed&.positive?

          total_seconds = case unit
                          when :mi then 1609.344 / speed
                          when :km then 1000 / speed
                          when :'100yd' then 91.44 / speed
                          when :'100m' then 100 / speed
                          end
          minutes, seconds = total_seconds.divmod(60)
          seconds = seconds.round
          if seconds == 60
            minutes += 1
            seconds = 0
          end
          seconds = seconds < 10 ? "0#{seconds}" : seconds.to_s
          "#{minutes}m#{seconds}s/#{unit}"
        end
      end
    end
  end
end

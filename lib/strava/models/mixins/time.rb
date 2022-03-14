# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module Time
        extend ActiveSupport::Concern

        included do
          property 'moving_time'
          property 'elapsed_time'
          property 'average_speed'
        end

        # always in meters per second, even in imperial splits
        def average_speed_meters_per_second
          elapsed_time
        end

        def moving_time_in_hours_s
          time_in_hours_s moving_time
        end

        def elapsed_time_in_hours_s
          time_in_hours_s elapsed_time
        end

        def pace_per_mile_s
          convert_meters_per_second_to_pace average_speed, :mi
        end

        def pace_per_100_yards_s
          convert_meters_per_second_to_pace average_speed, :'100yd'
        end

        def pace_per_100_meters_s
          convert_meters_per_second_to_pace average_speed, :'100m'
        end

        def pace_per_kilometer_s
          convert_meters_per_second_to_pace average_speed, :km
        end

        def kilometer_per_hour_s
          return unless average_speed&.positive?

          format('%.1fkm/h', average_speed * 3.6)
        end

        def miles_per_hour_s
          return unless average_speed&.positive?

          format('%.1fmph', average_speed * 2.23694)
        end

        def speed_s
          kilometer_per_hour_s
        end

        private

        def time_in_hours_s(time)
          return unless time

          hours = time / 3600 % 24
          minutes = time / 60 % 60
          seconds = time % 60
          [
            hours.to_i.positive? ? format('%dh', hours) : nil,
            minutes.to_i.positive? ? format('%dm', minutes) : nil,
            seconds.to_i.positive? ? format('%ds', seconds) : nil
          ].compact.join
        end

        # Convert speed (m/s) to pace (min/mile or min/km) in the format of 'x:xx'
        # http://yizeng.me/2017/02/25/convert-speed-to-pace-programmatically-using-ruby
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

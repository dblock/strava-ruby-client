# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides local start date/time with timezone handling.
      #
      # This mixin adds the start_date_local property and handles proper timezone
      # conversion. It attempts to use the 'timezone' property if available, or
      # calculates the timezone offset from the difference between start_date
      # (UTC) and start_date_local.
      #
      # This is particularly important for activities that cross timezone boundaries
      # or for displaying times in the athlete's local timezone.
      #
      # @example Using local start date
      #   activity = client.activity(1234567890)
      #   puts activity.start_date        # => 2024-01-15 14:30:00 UTC
      #   puts activity.start_date_local  # => 2024-01-15 09:30:00 -0500
      #
      module StartDateLocal
        extend ActiveSupport::Concern

        included do
          property 'start_date_local', transform_with: ->(v) { ::Time.parse(v) }

          #
          # Returns the start date/time in the local timezone.
          #
          # Constructs a Time object with the proper timezone offset based on
          # the 'timezone' property or calculated from the difference between
          # start_date and start_date_local.
          #
          # @return [Time] Start date/time with local timezone
          #
          def start_date_local
            extracted_datetime = self['start_date_local']
            # Some Strava objects do not contain a timezone property (e.g., Lap)
            timezone_shift = conditional_timezone(extracted_datetime)
            ::Time.new(extracted_datetime.year,
                       extracted_datetime.month,
                       extracted_datetime.day,
                       extracted_datetime.hour,
                       extracted_datetime.min,
                       extracted_datetime.sec,
                       timezone_shift)
          end

          private

          #
          # Determines the timezone offset for the start date.
          #
          # If a 'timezone' property exists, parses it to extract the offset.
          # Otherwise, calculates the offset from the difference between
          # start_date (UTC) and start_date_local.
          #
          # @param extracted_datetime [Time] The parsed start_date_local value
          # @return [String] Timezone offset string (e.g., "-05:00")
          #
          # @api private
          #
          def conditional_timezone(extracted_datetime)
            if key?(:timezone)
              if timezone.include?('+')
                timezone_shift_string('+')
              elsif timezone.include?('-')
                timezone_shift_string('-')
              else
                raise ArgumentError 'No operator of timezone correction detectable!'
              end
            else
              calculate_timezone(extracted_datetime)
            end
          end

          def calculate_timezone(extracted_datetime)
            if start_date == extracted_datetime
              timezone_diff_shift_string(0, '-')
            elsif extracted_datetime < start_date
              timezone_diff_shift_string((extracted_datetime - start_date), '-')
            elsif extracted_datetime > start_date
              timezone_diff_shift_string((extracted_datetime - start_date), '+')
            else
              raise ArgumentError 'No operator of timezone correction detectable!'
            end
          end

          def timezone_shift_string(operator)
            diff_hours = timezone.split(operator).last.to_i
            "#{operator}#{format_int_leading_zero(diff_hours)}:00"
          end

          def timezone_diff_shift_string(time_diff, operator)
            diff_hours = (time_diff.abs / 3600).to_i
            "#{operator}#{format_int_leading_zero(diff_hours)}:00"
          end

          def format_int_leading_zero(int)
            format('%02d', int)
          end
        end
      end
    end
  end
end

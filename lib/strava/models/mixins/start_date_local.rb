# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module StartDateLocal
        extend ActiveSupport::Concern

        included do
          property 'start_date_local', transform_with: ->(v) { ::Time.parse(v) }

          def start_date_local
            extracted_datetime = self['start_date_local']
            # some strava object do not contain a timezone property i.e. `Lap`
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

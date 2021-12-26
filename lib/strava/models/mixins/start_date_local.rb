module Strava
  module Models
    module Mixins
      module StartDateLocal
        extend ActiveSupport::Concern

        included do
          property 'start_date_local', transform_with: ->(v) { ::Time.parse(v) }

          def start_date_local
            dt = self['start_date_local']
            # some strava object do not contain a timezone property i.e. `Lap`
            timezone_shift = conditional_timezone(dt)
            ::Time.new(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec, timezone_shift)
          end

          private

          def conditional_timezone(dt)
            if key?(:timezone)
              if timezone.include?('+')
                timezone_shift_string('+')
              elsif timezone.include?('-')
                timezone_shift_string('-')
              else
                raise ArgumentError 'No operator of timezone correction detectable!'
              end
            else
              calculate_timezone(dt)
            end
          end

          def calculate_timezone(dt)
            if start_date == dt
              timezone_diff_shift_string((dt - dt), '-')
            elsif dt < start_date
              timezone_diff_shift_string((dt - start_date), '-')
            elsif dt > start_date
              timezone_diff_shift_string((dt - start_date), '+')
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
            '%02d' % int
          end
        end
      end
    end
  end
end

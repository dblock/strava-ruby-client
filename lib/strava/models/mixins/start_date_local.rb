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
            unless try(:timeout)
              shift = "-0#{((start_date - dt) / 3600).to_i}:00"
              return ::Time.new(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec, shift)
            end

            if timezone.include?('+')
              "+0#{timezone.split('+').last.to_i}:00"
            elsif timezone.include?('-')
              "-0#{timezone.split('-').last.to_i}:00"
            end
            ::Time.new(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec, shift)
          end
        end
      end
    end
  end
end

module Strava
  module Models
    module Mixins
      module StartDateLocal
        extend ActiveSupport::Concern

        included do
          property 'start_date_local', transform_with: ->(v) { ::Time.parse(v) }
          def start_date_local
            shift = begin
                if timezone.include?('+')
                  "+0#{timezone.split('+').last.to_i}:00"
                elsif timezone.include?('-')
                  "-0#{timezone.split('-').last.to_i}:00"
                end
                    rescue NameError
                      "-0#{((start_date - self['start_date_local']) / 3600).to_i}:00"
              end

            local_start_date = self['start_date_local']
            ::Time.new(local_start_date.year, local_start_date.month, local_start_date.day, local_start_date.hour, local_start_date.min, local_start_date.sec, shift)
          end
        end
      end
    end
  end
end

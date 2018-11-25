module Strava
  module Models
    module Mixins
      module Elevation
        extend ActiveSupport::Concern

        included do
          property 'total_elevation_gain'
        end

        def total_elevation_gain_in_feet
          case units
          when :metric then total_elevation_gain * 3.28084
          when :imperial then total_elevation_gain
          end
        end

        def total_elevation_gain_in_meters
          case units
          when :metric then total_elevation_gain
          when :imperial then total_elevation_gain / 3.28084
          end
        end

        def total_elevation_gain_in_meters_s
          return unless total_elevation_gain && total_elevation_gain.positive?

          format('%gm', format('%.1f', total_elevation_gain_in_meters))
        end

        def total_elevation_gain_in_feet_s
          return unless total_elevation_gain && total_elevation_gain.positive?

          format('%gft', format('%.1f', total_elevation_gain_in_feet))
        end

        def total_elevation_gain_s
          case units
          when :metric then total_elevation_gain_in_meters_s
          when :imperial then total_elevation_gain_in_feet_s
          end
        end
      end
    end
  end
end

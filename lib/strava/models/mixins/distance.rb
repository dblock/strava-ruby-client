module Strava
  module Models
    module Mixins
      module Distance
        extend ActiveSupport::Concern

        included do
          property 'distance'
        end

        def distance_in_meters
          case units
          when :metric then distance
          when :imperial then distance / 3.28084
          end
        end

        def distance_in_feet
          case units
          when :metric then distance * 3.28084
          when :imperial then distance
          end
        end

        def distance_in_miles
          case units
          when :metric then distance_in_meters * 0.00062137
          when :imperial then distance_in_feet / 5280
          end
        end

        def distance_in_miles_s
          return unless distance && distance.positive?

          format('%gmi', format('%.2f', distance_in_miles))
        end

        def distance_in_yards
          distance_in_meters * 1.09361
        end

        def distance_in_yards_s
          return unless distance && distance.positive?

          format('%gyd', format('%.1f', distance_in_yards))
        end

        def distance_in_meters_s
          return unless distance && distance.positive?

          format('%gm', format('%d', distance_in_meters))
        end

        def distance_in_kilometers
          distance_in_meters / 1000
        end

        def distance_in_kilometers_s
          return unless distance && distance.positive?

          format('%gkm', format('%.2f', distance_in_kilometers))
        end

        def distance_s
          case units
          when :metric then distance_in_kilometers_s
          when :imperial then distance_in_miles_s
          end
        end
      end
    end
  end
end

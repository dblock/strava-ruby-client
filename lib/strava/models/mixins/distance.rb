# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module Distance
        extend ActiveSupport::Concern

        included do
          property 'distance'
        end

        def distance_in_meters
          distance
        end

        def distance_in_feet
          distance * 3.28084
        end

        def distance_in_miles
          distance_in_meters * 0.00062137
        end

        def distance_in_miles_s
          return unless distance&.positive?

          format('%gmi', format('%.2f', distance_in_miles))
        end

        def distance_in_yards
          distance_in_meters * 1.09361
        end

        def distance_in_yards_s
          return unless distance&.positive?

          format('%gyd', format('%.1f', distance_in_yards))
        end

        def distance_in_meters_s
          return unless distance&.positive?

          format('%gm', format('%d', distance_in_meters))
        end

        def distance_in_kilometers
          distance_in_meters / 1000
        end

        def distance_in_kilometers_s
          return unless distance&.positive?

          format('%gkm', format('%.2f', distance_in_kilometers))
        end

        def distance_s
          distance_in_kilometers_s
        end
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module ElevationDifference
        extend ActiveSupport::Concern

        included do
          property 'elevation_difference'
        end

        def elevation_difference_in_feet
          elevation_difference * 3.28084
        end

        def elevation_difference_in_meters
          elevation_difference
        end

        def elevation_difference_in_meters_s
          return if elevation_difference.nil?

          format('%gm', format('%.1f', elevation_difference_in_meters))
        end

        def elevation_difference_in_feet_s
          return if elevation_difference.nil?

          format('%gft', format('%.1f', elevation_difference_in_feet))
        end

        def elevation_difference_s
          elevation_difference_in_meters_s
        end
      end
    end
  end
end

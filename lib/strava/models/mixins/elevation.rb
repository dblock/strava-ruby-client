# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module Elevation
        extend ActiveSupport::Concern

        included do
          property 'total_elevation_gain'
        end

        def total_elevation_gain_in_feet
          total_elevation_gain * 3.28084
        end

        def total_elevation_gain_in_meters
          total_elevation_gain
        end

        def total_elevation_gain_in_meters_s
          return if total_elevation_gain.nil?

          format('%gm', format('%.1f', total_elevation_gain_in_meters))
        end

        def total_elevation_gain_in_feet_s
          return if total_elevation_gain.nil?

          format('%gft', format('%.1f', total_elevation_gain_in_feet))
        end

        def total_elevation_gain_s
          total_elevation_gain_in_meters_s
        end
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module ElevationGain
        extend ActiveSupport::Concern

        included do
          property 'elevation_gain'
        end

        def elevation_gain_in_feet
          elevation_gain * 3.28084
        end

        def elevation_gain_in_meters
          elevation_gain
        end

        def elevation_gain_in_meters_s
          return if elevation_gain.nil?

          format('%gm', format('%.1f', elevation_gain_in_meters))
        end

        def elevation_gain_in_feet_s
          return if elevation_gain.nil?

          format('%gft', format('%.1f', elevation_gain_in_feet))
        end

        def elevation_gain_s
          elevation_gain_in_meters_s
        end
      end
    end
  end
end

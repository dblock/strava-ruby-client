module Strava
  module Models
    class Split < Model
      include Mixins::Distance
      include Mixins::Time
      include Mixins::Elevation

      property 'elevation_difference'
      property 'total_elevation_gain', from: 'elevation_difference'
      property 'split'
      property 'average_heartrate'
      property 'pace_zone'

      class Standard < Split
        private

        def units
          :imperial
        end
      end

      class Metric < Split
        def units
          :metric
        end
      end
    end
  end
end

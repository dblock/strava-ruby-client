# frozen_string_literal: true

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
    end
  end
end

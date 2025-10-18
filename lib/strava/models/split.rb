# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Split
    class Split < Strava::Models::Response
      include Mixins::AverageSpeed
      include Mixins::Distance
      include Mixins::ElapsedTime
      include Mixins::ElevationDifference
      property 'pace_zone'
      include Mixins::MovingTime
      property 'split'
      # undocumented
      property 'average_grade_adjusted_speed'
      property 'average_heartrate'
    end
  end
end

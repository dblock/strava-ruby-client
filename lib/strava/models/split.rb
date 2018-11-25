module Strava
  module Models
    class Split < Model
      property 'distance'
      property 'elapsed_time'
      property 'elevation_difference'
      property 'moving_time'
      property 'split'
      property 'average_speed'
      property 'average_heartrate'
      property 'pace_zone'
    end
  end
end

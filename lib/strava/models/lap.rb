module Strava
  module Models
    class Lap < Model
      property 'id'
      property 'resource_state'
      property 'name'
      property 'activity', transform_with: ->(v) { Strava::Models::Activity.new(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'elapsed_time'
      property 'moving_time'
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'distance'
      property 'start_index'
      property 'end_index'
      property 'total_elevation_gain'
      property 'average_speed'
      property 'max_speed'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'lap_index'
      property 'split'
      property 'pace_zone'
    end
  end
end

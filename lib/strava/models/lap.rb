module Strava
  module Models
    class Lap < Model
      include Mixins::Time
      include Mixins::Distance
      include Mixins::Elevation

      property 'id'
      property 'resource_state'
      property 'name'
      property 'activity', transform_with: ->(v) { Strava::Models::Activity.new(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'start_index'
      property 'end_index'
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

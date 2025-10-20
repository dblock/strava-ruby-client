# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Lap
    class Lap < Strava::Models::Response
      property 'id'
      property 'activity', transform_with: ->(v) { Strava::Models::MetaActivity.new(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }
      property 'average_cadence'
      property 'average_speed'
      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      property 'start_index'
      property 'end_index'
      property 'lap_index'
      property 'max_speed'
      property 'name'
      property 'pace_zone'
      property 'split'
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      include Mixins::StartDateLocal
      include Mixins::TotalElevationGain
      # undocumented
      property 'resource_state'
      property 'device_watts'
      property 'average_watts'
      property 'average_heartrate'
      property 'max_heartrate'
    end
  end
end

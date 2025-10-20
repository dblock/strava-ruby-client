# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-ClubActivity
    class ClubActivity < Strava::Models::Response
      include Mixins::ElevationGain
      include Mixins::SportType

      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }
      property 'name'
      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::TotalElevationGain
      include Mixins::SportType
      property 'workout_type'
      # undocumented
      property 'resource_state'
    end
  end
end

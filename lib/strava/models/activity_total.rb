# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-ActivityTotal
    class ActivityTotal < Strava::Models::Response
      property 'count'
      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::ElevationGain
      property 'achievement_count'
    end
  end
end

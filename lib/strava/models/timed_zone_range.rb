# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-TimedZoneRange
    class TimedZoneRange < Strava::Models::Response
      property 'max'
      property 'min'
      property 'time'
    end
  end
end

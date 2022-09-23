# frozen_string_literal: true

module Strava
  module Models
    class TimedZoneRange < Strava::Models::Response
      property 'max'
      property 'min'
      property 'time'
    end
  end
end

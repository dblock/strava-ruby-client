# frozen_string_literal: true

module Strava
  module Models
    class TimedZoneRange < Response
      property 'max'
      property 'min'
      property 'time'
    end
  end
end

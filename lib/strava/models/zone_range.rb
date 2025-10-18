# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-ZoneRange
    class ZoneRange < Strava::Models::Response
      property 'max'
      property 'min'
    end
  end
end

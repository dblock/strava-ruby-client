# frozen_string_literal: true

module Strava
  module Models
    class ZoneRange < Strava::Models::Response
      property 'max'
      property 'min'
    end
  end
end

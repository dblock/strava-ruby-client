# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Zones
    class Zones < Strava::Models::Response
      property 'heart_rate', transform_with: ->(v) { Strava::Models::HeartRateZoneRanges.new(v) }
      property 'power', transform_with: ->(v) { Strava::Models::PowerZoneRanges.new(v) }
    end
  end
end

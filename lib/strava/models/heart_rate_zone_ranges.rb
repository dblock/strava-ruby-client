# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-HeartRateZoneRanges
    class HeartRateZoneRanges < Strava::Models::Response
      property 'custom_zones'
      property 'zones', transform_with: ->(v) { v.map { |r| Strava::Models::ZoneRange.new(r) } }
    end
  end
end

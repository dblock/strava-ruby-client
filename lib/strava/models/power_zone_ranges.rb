# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-PowerZoneRanges
    class PowerZoneRanges < Strava::Models::Response
      property 'zones', transform_with: ->(v) { v.map { |r| Strava::Models::ZoneRange.new(r) } }
    end
  end
end

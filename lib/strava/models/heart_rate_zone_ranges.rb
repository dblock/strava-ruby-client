# frozen_string_literal: true

module Strava
  module Models
    class HeartRateZoneRanges < Model
      property 'custom_zones'
      property 'zones', transform_with: ->(v) { v.map { |r| Strava::Models::ZoneRange.new(r) } }
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    class PowerZoneRanges < Model
      property 'zones', transform_with: ->(v) { v.map { |r| Strava::Models::ZoneRange.new(r) } }
    end
  end
end

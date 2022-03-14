# frozen_string_literal: true

module Strava
  module Models
    class Zones < Model
      property 'heart_rate', transform_with: ->(v) { Strava::Models::HeartRateZoneRanges.new(v) }
      property 'power', transform_with: ->(v) { Strava::Models::PowerZoneRanges.new(v) }
    end
  end
end

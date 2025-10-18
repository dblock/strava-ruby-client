# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-ActivityZone
    class ActivityZone < Strava::Models::Response
      property 'score'
      property 'distribution_buckets', transform_with: ->(v) { v.map { |r| Strava::Models::TimedZoneRange.new(r) } }
      property 'type'
      property 'sensor_based'
      property 'points'
      property 'custom_zones'
      property 'max'
      # undocumented
      property 'resource_state'
    end
  end
end

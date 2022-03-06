module Strava
  module Models
    class ActivityZone < Model
      include Mixins::Ratelimit

      property 'score'
      property 'distribution_buckets', transform_with: ->(v) { v.map { |r| Strava::Models::TimedZoneRange.new(r) } }
      property 'type'
      property 'resource_state'
      property 'sensor_based'
      property 'points'
      property 'custom_zones'
    end
  end
end

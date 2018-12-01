module Strava
  module Models
    class SegmentEffort < Model
      include Mixins::MetricDistance
      include Mixins::Time

      property 'id'
      property 'resource_state'
      property 'name'
      property 'activity', transform_with: ->(v) { Strava::Models::Activity.new(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'start_index'
      property 'end_index'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'segment', transform_with: ->(v) { Strava::Models::Segment.new(v) }
      property 'achievements', transform_with: ->(v) { v.map { |r| Strava::Models::Achievement.new(r) } }
      property 'hidden'
      property 'pr_rank'
      property 'average_cadence'
      property 'device_watts'
      property 'average_watts'
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SegmentStats.new(v) }
      property 'is_kom'
    end
  end
end

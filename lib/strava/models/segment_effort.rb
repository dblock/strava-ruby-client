module Strava
  module Models
    class SegmentEffort < Model
      include Mixins::Time

      property 'id'
      property 'resource_state'
      property 'name'
      property 'activity', transform_with: ->(v) { Strava::Models::Activity.new(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'distance'
      property 'start_index'
      property 'end_index'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'segment', transform_with: ->(v) { Strava::Models::Segment.new(v) }
      property 'achievements'
      property 'hidden'
      property 'pr_rank'
    end
  end
end

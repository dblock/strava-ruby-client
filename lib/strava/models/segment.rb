module Strava
  module Models
    class Segment < Model
      include Mixins::Distance
      include Mixins::Elevation
      include Mixins::Time

      property 'id'
      property 'resource_state'
      property 'name'
      property 'maximum_grade'
      property 'elevation_high'
      property 'elevation_low'
      property 'activity_type'
      property 'average_grade'
      property 'climb_category'
      property 'city'
      property 'state'
      property 'country'
      property 'start_latlng'
      property 'end_latlng'
      property 'start_latitude'
      property 'start_longitude'
      property 'end_latitude'
      property 'end_longitude'
      property 'private'
      property 'hazardous'
      property 'starred'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'effort_count'
      property 'athlete_count'
      property 'star_count'
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SegmentStats.new(v) }
      property 'pr_time'
      property 'athlete_pr_effort', transform_with: ->(v) { Strava::Models::SegmentEffort.new(v) }
      property 'starred_date', transform_with: ->(v) { Time.parse(v) }

      def elapsed_time
        pr_time
      end
    end
  end
end

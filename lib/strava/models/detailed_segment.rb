# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-DetailedSegment
    class DetailedSegment < Strava::Models::Response
      property 'id'
      property 'name'
      property 'activity_type'
      include Mixins::Distance
      property 'average_grade'
      property 'maximum_grade'
      property 'elevation_high'
      property 'elevation_low'
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }
      property 'end_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }
      property 'climb_category'
      property 'city'
      property 'state'
      property 'country'
      property 'private'
      property 'athlete_pr_effort', transform_with: ->(v) { Strava::Models::SummaryPRSegmentEffort.new(v) }
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SummarySegmentEffort.new(v) }
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      include Mixins::TotalElevationGain
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'effort_count'
      property 'athlete_count'
      property 'hazardous'
      property 'star_count'
      # undocumented
      property 'resource_state'
      property 'elevation_profile'
      property 'elevation_profiles'
      property 'starred'
      property 'xoms', transform_with: ->(v) { Strava::Models::Xoms.new(v) }
      property 'local_legend', transform_with: ->(v) { Strava::Models::LocalLegend.new(v) }
    end
  end
end

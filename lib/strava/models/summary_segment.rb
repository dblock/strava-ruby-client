# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-SummarySegment
    class SummarySegment < Strava::Models::Response
      property 'id'
      property 'name'
      property 'activity_type'
      include Mixins::Distance
      property 'average_grade'
      property 'maximum_grade'
      property 'elevation_high'
      property 'elevation_low'
      property 'start_latlng'
      property 'end_latlng'
      property 'climb_category'
      property 'city'
      property 'state'
      property 'country'
      property 'private'
      property 'athlete_pr_effort', transform_with: ->(v) { Strava::Models::SummaryPRSegmentEffort.new(v) }
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SummarySegmentEffort.new(v) }
      # undocumented
      property 'resource_state'
      property 'elevation_profile'
      property 'elevation_profiles'
      property 'hazardous'
      property 'starred'
      property 'starred_date', transform_with: ->(v) { Time.parse(v) }
      property 'pr_time'
    end
  end
end

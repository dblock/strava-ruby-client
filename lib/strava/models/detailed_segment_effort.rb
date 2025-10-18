# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-DetailedSegmentEffort
    class DetailedSegmentEffort < Strava::Models::Response
      property 'id'
      property 'activity_id'
      include Mixins::ElapsedTime
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      include Mixins::StartDateLocal
      include Mixins::Distance
      property 'is_kom'
      property 'name'
      # documented as MetaActivity and MetaAthlete
      property 'activity', transform_with: ->(v) { Strava::Models::MetaActivity.new(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }
      include Mixins::MovingTime
      property 'start_index'
      property 'end_index'
      property 'average_cadence'
      property 'average_watts'
      property 'device_watts'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'segment', transform_with: ->(v) { Strava::Models::SummarySegment.new(v) }
      property 'kom_rank'
      property 'pr_rank'
      property 'hidden'
      # undocumented
      property 'resource_state'
      property 'achievements', transform_with: ->(v) { v.map { |r| Strava::Models::Achievement.new(r) } }
      property 'visibility'
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SummaryPRSegmentEffort.new(v) }
    end
  end
end

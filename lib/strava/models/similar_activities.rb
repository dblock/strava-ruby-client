# frozen_string_literal: true

module Strava
  module Models
    # Undocumented
    class SimilarActivities < Strava::Models::Response
      property 'average_speed'
      property 'resource_state'
      property 'effort_count'
      property 'frequency_milestone'
      property 'max_average_speed'
      property 'mid_average_speed'
      property 'min_average_speed'
      property 'mid_speed'
      property 'min_speed'
      property 'speeds'
      property 'trend', transform_with: ->(v) { Strava::Models::Trend.new(v) }
      property 'pr_rank'
    end
  end
end

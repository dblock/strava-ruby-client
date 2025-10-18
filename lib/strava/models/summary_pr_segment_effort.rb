# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-SummaryPRSegmentEffort
    class SummaryPRSegmentEffort < Strava::Models::Response
      property 'pr_activity_id'
      property 'pr_elapsed_time'
      property 'pr_date', transform_with: ->(v) { Date.parse(v) }
      property 'effort_count'
      # undocumented
      property 'pr_visibility'
      property 'pr_activity_visibility'
    end
  end
end

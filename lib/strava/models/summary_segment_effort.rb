# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-SummarySegmentEffort
    class SummarySegmentEffort < Strava::Models::Response
      property 'id'
      property 'activity_id'
      include Mixins::ElapsedTime
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      include Mixins::StartDateLocal
      include Mixins::Distance
      property 'is_kom'
    end
  end
end

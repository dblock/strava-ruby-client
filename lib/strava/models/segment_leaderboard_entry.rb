# frozen_string_literal: true

module Strava
  module Models
    class SegmentLeaderboardEntry < Model
      include Mixins::Time
      include Mixins::StartDateLocal

      property 'athlete_name'
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'rank'
    end
  end
end

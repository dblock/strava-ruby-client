module Strava
  module Models
    class SegmentLeaderboardEntry < Model
      include Mixins::Time

      property 'athlete_name'
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'rank'
    end
  end
end

module Strava
  module Models
    class SegmentLeaderboard < Model
      property 'effort_count'
      property 'entry_count'
      property 'kom_type'
      property 'entries', transform_with: ->(v) { v.map { |r| SegmentLeaderboardEntry.new(r) } }
    end
  end
end

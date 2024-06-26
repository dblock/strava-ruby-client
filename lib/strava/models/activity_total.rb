# frozen_string_literal: true

module Strava
  module Models
    class ActivityTotal < Strava::Models::Response
      include Mixins::Distance
      include Mixins::Time
      include Mixins::Elevation

      property 'count'
      property 'achievement_count'
      property 'elevation_gain'

      def total_elevation_gain
        elevation_gain
      end
    end
  end
end

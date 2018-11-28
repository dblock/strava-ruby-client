module Strava
  module Models
    class ActivityStats < Model
      property 'biggest_ride_distance'
      property 'biggest_climb_elevation_gain'
      property 'recent_ride_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'recent_run_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'recent_swim_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'ytd_ride_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'ytd_run_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'ytd_swim_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'all_ride_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'all_run_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
      property 'all_swim_totals', transform_with: ->(v) { Strava::Models::ActivityTotal.new(v) }
    end
  end
end

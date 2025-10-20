# frozen_string_literal: true

module Strava
  module Models
    # Undocumented
    class LocalLegend < Strava::Models::Response
      property 'athlete_id'
      property 'title'
      property 'profile'
      property 'effort_description'
      property 'effort_count'
      property 'effort_counts'
      property 'destination'
    end
  end
end

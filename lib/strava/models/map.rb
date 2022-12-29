# frozen_string_literal: true

module Strava
  module Models
    class Map < Strava::Models::Response
      property 'id'
      property 'summary_polyline'
      property 'resource_state'
      property 'polyline'
    end
  end
end

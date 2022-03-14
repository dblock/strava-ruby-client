# frozen_string_literal: true

module Strava
  module Models
    class Map < Model
      property 'id'
      property 'summary_polyline'
      property 'resource_state'
      property 'polyline'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Waypoint
    class Waypoint < Strava::Models::Response
      property 'latlng'
      property 'target_latlng'
      property 'categories'
      property 'title'
      property 'description'
      property 'distance_into_route'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Waypoint
    class Waypoint < Strava::Models::Response
      property 'latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }
      property 'target_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }
      property 'categories'
      property 'title'
      property 'description'
      property 'distance_into_route'
    end
  end
end

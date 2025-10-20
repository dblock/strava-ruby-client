# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Route
    class Route < Strava::Models::Response
      property 'athlete', transform_with: ->(v) { Strava::Models::SummaryAthlete.new(v) }
      property 'description'
      include Mixins::Distance
      include Mixins::ElevationGain
      property 'id'
      property 'id_str'
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'name'
      property 'private'
      property 'starred'
      property 'timestamp', transform_with: ->(v) { Time.at(v) }
      property 'type'
      property 'sub_type'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      include Mixins::EstimatedMovingTime
      property 'segments', transform_with: ->(v) { v.map { |r| Strava::Models::SummarySegment.new(r) } }
      property 'waypoints', transform_with: ->(v) { v.map { |r| Strava::Models::Waypoint.new(r) } }
      # undocumented
      property 'map_urls'
      property 'resource_state'
    end
  end
end

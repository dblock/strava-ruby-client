# frozen_string_literal: true

module Strava
  module Models
    class Route < Model
      include Mixins::Distance
      include Mixins::Elevation
      include Mixins::Time

      property 'id'
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'name'
      property 'description'
      property 'total_elevation_gain', from: 'elevation_gain'
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'private'
      property 'resource_state'
      property 'starred'
      property 'sub_type'
      property 'timestamp', transform_with: ->(v) { Time.at(v) }
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      property 'type'
      property 'estimated_moving_time'
      property 'moving_time', from: 'estimated_moving_time'
      property 'segments', transform_with: ->(v) { v.map { |r| Strava::Models::Segment.new(r) } }
    end
  end
end

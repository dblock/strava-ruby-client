# frozen_string_literal: true

module Strava
  module Models
    class StreamSet < Model
      property 'distance', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'time', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'latlng', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'altitude', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'velocity_smooth', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'heartrate', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'cadence', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'watts', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'temp', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'moving', transform_with: ->(v) { Strava::Models::Stream.new(v) }
      property 'grade_smooth', transform_with: ->(v) { Strava::Models::Stream.new(v) }
    end
  end
end

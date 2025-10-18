# frozen_string_literal: true

module Strava
  module Models
    # undocumented
    class DetailedPhotos < Strava::Models::Response
      property 'primary', transform_with: ->(v) { Strava::Models::Photo.new(v) }
      property 'use_primary_photo'
      property 'count'
    end
  end
end

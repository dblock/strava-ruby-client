# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-PhotosSummary
    class PhotosSummary < Strava::Models::Response
      property 'count'
      property 'use_primary_photo' # undocumented
      property 'primary', transform_with: ->(v) { Strava::Models::PhotosSummaryPrimary.new(v) }
    end
  end
end

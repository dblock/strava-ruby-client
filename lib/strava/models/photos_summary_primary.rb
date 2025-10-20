# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-PhotosSummary_primary
    class PhotosSummaryPrimary < Strava::Models::Response
      property 'id'
      property 'source'
      property 'unique_id'
      property 'urls'
      # undocumented
      property 'media_type'
    end
  end
end

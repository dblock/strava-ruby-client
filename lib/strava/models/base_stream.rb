# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-BaseStream
    class BaseStream < Strava::Models::Response
      property 'original_size'
      property 'resolution'
      property 'series_type'
    end
  end
end

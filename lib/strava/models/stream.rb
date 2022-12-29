# frozen_string_literal: true

module Strava
  module Models
    class Stream < Strava::Models::Response
      property 'original_size'
      property 'resolution'
      property 'series_type'
      property 'data'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    class Stream < Model
      property 'original_size'
      property 'resolution'
      property 'series_type'
      property 'data'
    end
  end
end

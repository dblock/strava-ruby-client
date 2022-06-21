# frozen_string_literal: true

module Strava
  module Models
    class Trend < Response
      property 'speeds'
      property 'current_activity_index'
      property 'min_speed'
      property 'mid_speed'
      property 'max_speed'
      property 'direction'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides estimated moving time formatting methods.
      #
      # Estimated moving time is Strava's prediction of how long it will take
      # to complete a route based on distance, elevation, and typical speeds.
      # This is commonly used for routes.
      #
      # @example Using estimated moving time helpers
      #   route = client.route(1234567)
      #   puts route.estimated_moving_time              # => 5400 (seconds)
      #   puts route.estimated_moving_time_in_hours_s   # => "1h30m"
      #
      module EstimatedMovingTime
        extend ActiveSupport::Concern
        include TimeInHours

        included do
          # @return [Integer] Estimated moving time in seconds
          property 'estimated_moving_time'
        end

        #
        # Returns formatted estimated moving time as hours, minutes, and seconds.
        #
        # @return [String, nil] Formatted time string (e.g., "1h23m45s", "45m30s", "30s")
        #
        def estimated_moving_time_in_hours_s
          time_in_hours_s estimated_moving_time
        end
      end
    end
  end
end

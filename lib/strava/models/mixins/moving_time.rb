# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides moving time formatting methods.
      #
      # Moving time is the time spent actually moving during an activity, excluding
      # stopped time. This mixin adds the moving_time property and a helper method
      # to format it as hours/minutes/seconds.
      #
      # @example Using moving time helpers
      #   activity = client.activity(1234567890)
      #   puts activity.moving_time              # => 3665 (seconds)
      #   puts activity.moving_time_in_hours_s   # => "1h1m5s"
      #
      module MovingTime
        extend ActiveSupport::Concern
        include TimeInHours

        included do
          # @return [Integer] Moving time in seconds (excludes stopped time)
          property 'moving_time'
        end

        #
        # Returns formatted moving time as hours, minutes, and seconds.
        #
        # @return [String, nil] Formatted time string (e.g., "1h23m45s", "45m30s", "30s")
        #
        def moving_time_in_hours_s
          time_in_hours_s moving_time
        end
      end
    end
  end
end

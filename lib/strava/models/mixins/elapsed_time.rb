# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides elapsed time formatting methods.
      #
      # Elapsed time is the total time from start to finish of an activity, including
      # stopped/paused time. This mixin adds the elapsed_time property and a helper
      # method to format it as hours/minutes/seconds.
      #
      # @example Using elapsed time helpers
      #   activity = client.activity(1234567890)
      #   puts activity.elapsed_time              # => 4200 (seconds)
      #   puts activity.elapsed_time_in_hours_s   # => "1h10m"
      #
      module ElapsedTime
        extend ActiveSupport::Concern
        include TimeInHours

        included do
          # @return [Integer] Total elapsed time in seconds (includes stopped time)
          property 'elapsed_time'
        end

        #
        # Returns formatted elapsed time as hours, minutes, and seconds.
        #
        # @return [String, nil] Formatted time string (e.g., "1h23m45s", "45m30s", "30s")
        #
        def elapsed_time_in_hours_s
          time_in_hours_s elapsed_time
        end
      end
    end
  end
end

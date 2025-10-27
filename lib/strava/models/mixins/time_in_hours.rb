# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides time formatting helper methods.
      #
      # This is a utility mixin used by other time-related mixins (MovingTime, ElapsedTime, etc.)
      # to format seconds into a human-readable hours/minutes/seconds string.
      #
      # @example Time formatting
      #   time_in_hours_s(3665)   # => "1h1m5s"
      #   time_in_hours_s(125)    # => "2m5s"
      #   time_in_hours_s(45)     # => "45s"
      #   time_in_hours_s(7200)   # => "2h"
      #
      module TimeInHours
        extend ActiveSupport::Concern

        private

        #
        # Converts time in seconds to formatted string with hours, minutes, and seconds.
        #
        # Only includes non-zero components. For example, if there are no hours,
        # the result will be "23m45s" instead of "0h23m45s".
        #
        # @param time [Integer, nil] Time in seconds
        # @return [String, nil] Formatted time string or nil if time is nil
        #
        # @api private
        #
        def time_in_hours_s(time)
          return unless time

          hours = time / 3600 % 24
          minutes = time / 60 % 60
          seconds = time % 60
          [
            hours.to_i.positive? ? format('%dh', hours) : nil,
            minutes.to_i.positive? ? format('%dm', minutes) : nil,
            seconds.to_i.positive? ? format('%ds', seconds) : nil
          ].compact.join
        end
      end
    end
  end
end

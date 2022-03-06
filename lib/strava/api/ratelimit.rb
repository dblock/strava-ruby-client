# frozen_string_literal: true

module Strava
  module Api
    class Ratelimit
      def initialize(response)
        @response = response
        @headers = response.headers
        @body = response.body
      end

      def to_s
        to_h.map do |k, v|
          "#{k}: #{v}"
        end.join(', ')
      end

      def to_h
        if limit?
          {
            limit: limit,
            usage: usage,
            fiveteen_minutes: fiveteen_minutes,
            total_day: total_day,
            fiveteen_minutes_usage: fiveteen_minutes_usage,
            total_day_usage: total_day_usage,
            fiveteen_minutes_remaining: fiveteen_minutes_remaining,
            total_day_remaining: total_day_remaining
          }
        else
          {}
        end
      end

      #
      # checks for presence of the header, as it is i.e. not included when
      # asking for a token.
      #
      # @return [TrueClass]
      #
      def limit?
        @headers.key?('x-ratelimit-limit')
      end

      #
      # returns a string containing the ratelimit for 15 minutes before the comma and
      # the daily ratelimit after the comma
      #
      # @return [String] of the ratelimits for 15 minutes and per day separated by comma
      #
      # @example
      #   ```ruby
      #   "600,30000"
      #   ```
      #
      def limit
        @headers['x-ratelimit-limit']
      end

      #
      # returns a string containing the used ratelimit for 15 minutes before the comma and
      # the daily ratelimit after the comma
      #
      # @return [String] of the used ratelimits for 15 minutes and per day separated by comma
      #
      # @example
      #   ```ruby
      #   "333,11337"
      #   ```
      #
      def usage
        @headers['x-ratelimit-usage']
      end

      def fiveteen_minutes
        limit? ? limit.split(',').first.to_i : nil
      end

      def total_day
        limit? ? limit.split(',').last.to_i : nil
      end

      def fiveteen_minutes_usage
        limit? ? usage.split(',').first.to_i : nil
      end

      def total_day_usage
        limit? ? usage.split(',').last.to_i : nil
      end

      def fiveteen_minutes_remaining
        return nil unless fiveteen_minutes && fiveteen_minutes_usage

        fiveteen_minutes.to_i - fiveteen_minutes_usage.to_i
      end

      def total_day_remaining
        return nil unless total_day && total_day_usage

        total_day.to_i - total_day_usage.to_i
      end
    end
  end
end

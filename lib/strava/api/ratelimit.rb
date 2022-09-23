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
            total_day: total_day,
            total_day_usage: total_day_usage,
            total_day_remaining: total_day_remaining,
            fiveteen_minutes: fiveteen_minutes,
            fiveteen_minutes_usage: fiveteen_minutes_usage,
            fiveteen_minutes_remaining: fiveteen_minutes_remaining
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
        limit? ? extract_ratelimit!(limit).first : nil
      end

      def total_day
        limit? ? extract_ratelimit!(limit).last : nil
      end

      def fiveteen_minutes_usage
        limit? ? extract_ratelimit!(usage).first : nil
      end

      def total_day_usage
        limit? ? extract_ratelimit!(usage).last : nil
      end

      def fiveteen_minutes_remaining
        return nil unless fiveteen_minutes && fiveteen_minutes_usage

        fiveteen_minutes - fiveteen_minutes_usage
      end

      def total_day_remaining
        return nil unless total_day && total_day_usage

        total_day - total_day_usage
      end

      private

      def extract_ratelimit!(ratelimit)
        @lookup_table_ratelimits ||= {}
        @lookup_table_ratelimits[ratelimit] ||= ratelimit.split(',').map(&:to_i)
      end
    end
  end
end

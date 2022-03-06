module Strava
  module Api
    class Ratelimit
      attr_reader :headers

      def initialize(headers)
        @headers = headers
      end

      def ratelimit_hash
        if ratelimit?
          {
            'ratelimit_limit' => limit,
            'ratelimit_usage' => usage,
            'ratelimit_fiveteen_minutes' => fiveteen_minutes,
            'ratelimit_total_day' => total_day,
            'ratelimit_fiveteen_minutes_usage' => fiveteen_minutes_usage,
            'ratelimit_total_day_usage' => total_day_usage,
            'ratelimit_fiveteen_minutes_remaining' => fiveteen_minutes_remaining,
            'ratelimit_total_day_remaining' => total_day_remaining
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
      def ratelimit?
        !@headers['x-ratelimit-limit'].nil?
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
        ratelimit? ? limit.split(',').first.to_i : 0
      end

      def total_day
        ratelimit? ? limit.split(',').last.to_i : 0
      end

      def fiveteen_minutes_usage
        ratelimit? ? usage.split(',').first.to_i : 0
      end

      def total_day_usage
        ratelimit? ? usage.split(',').last.to_i : 0
      end

      def fiveteen_minutes_remaining
        fiveteen_minutes.to_i - fiveteen_minutes_usage.to_i
      end

      def total_day_remaining
        total_day.to_i - total_day_usage.to_i
      end
    end
  end
end

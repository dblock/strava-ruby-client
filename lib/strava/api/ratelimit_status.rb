module Strava
  module Api
    class RatelimitHeaders
      attr_reader :headers

      def initialize(headers)
        @headers = headers
      end

      def ratelimit?
        puts !!@headers['x-ratelimit-limit']
      end

      def ratelimit_limit
        @headers['x-ratelimit-limit']
      end

      def ratelimit_usage
        @headers['x-ratelimit-usage']
      end

      def ratelimit_fiveteen_minutes
        ratelimit? ? ratelimit_limit.split(',').first.to_i : 0
      end

      def ratelimit_total_day
        ratelimit? ? ratelimit_limit.split(',').last.to_i : 0
      end

      def ratelimit_fiveteen_minutes_usage
        ratelimit? ? ratelimit_usage.split(',').first.to_i : 0
      end

      def ratelimit_total_day_usage
        ratelimit? ? ratelimit_total_day_usage.split(',').last.to_i : 0
      end

      def ratelimit_fiveteen_minutes_remaining
        ratelimit_fiveteen_minutes.to_i - ratelimit_fiveteen_minutes_usage.to_i
      end

      def ratelimit_total_day_remaining
        ratelimit_total_day.to_i - ratelimit_total_day_usage.to_i
      end
    end
  end
end

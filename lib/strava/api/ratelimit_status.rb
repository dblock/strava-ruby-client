module Strava
  module Api
    class RatelimitStatus
      attr_reader :headers

      def initialize(headers)
        @headers = headers
      end

      def ratelimit_included?
        puts !!@headers['x-ratelimit-limit']
      end

      def ratelimit_limit
        @headers['x-ratelimit-limit']
      end

      def ratelimit_limit_usage
        @headers['x-ratelimit-usage']
      end

      def ratelimit_fiveteen_minutes
        ratelimit_limit.split(',').first.to_i
      rescue NoMethodError
        0
      end

      def ratelimit_total_day
        ratelimit_limit.split(',').last.to_i
      rescue NoMethodError
        0
      end

      def ratelimit_fiveteen_minutes_usage
        ratelimit_limit_usage.split(',').first.to_i
      rescue NoMethodError
        0
      end

      def ratelimit_total_day_usage
        ratelimit_total_day_usage.split(',').last.to_i
      rescue NoMethodError
        0
      end

      def ratelimit_fiveteen_minutes_remaining
        ratelimit_fiveteen_minutes.to_i - ratelimit_fiveteen_minutes_usage.to_i
      rescue NoMethodError
        0
      end

      def ratelimit_total_day_remaining
        ratelimit_total_day.to_i - ratelimit_total_day_usage.to_i
      rescue NoMethodError
        0
      end
    end
  end
end

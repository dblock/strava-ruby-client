# frozen_string_literal: true

module Strava
  module Api
    class RatelimitError < StandardError
      attr_reader :ratelimit

      def initialize(response)
        super
        @ratelimit = Strava::Api::Ratelimit.new(response)
      end
    end

    class Ratelimit
      def initialize(response)
        @response = response
        @headers = response.headers
        @body = response.body
      end

      def exceeded
        return false unless limit?

        @exceeded ||= if fifteen_minutes_remaining && fifteen_minutes_remaining <= 0
                        { fifteen_minutes_remaining: fifteen_minutes_remaining }
                      elsif  total_day_remaining && total_day_remaining <= 0
                        { total_day_remaining: total_day_remaining }
                      end
      end

      def exceeded?
        !!exceeded
      end

      def to_s
        to_h.map do |k, v|
          "#{k}: #{v}"
        end.join(', ')
      end

      #
      # represents all valid ratelimits in a Hash
      #
      # @return [Hash] of ratelimits
      #
      def to_h
        if limit?
          {
            limit: limit,
            usage: usage,
            total_day: total_day,
            total_day_usage: total_day_usage,
            total_day_remaining: total_day_remaining,
            fifteen_minutes: fifteen_minutes,
            fifteen_minutes_usage: fifteen_minutes_usage,
            fifteen_minutes_remaining: fifteen_minutes_remaining
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

      #
      # fifteen minute ratelimit
      #
      # @return [NilClass] if no ratelimit in http headers
      # @return [Integer] representing the ratelimit
      #
      def fifteen_minutes
        limit? ? extract_ratelimit!(limit).first : nil
      end

      #
      # total day ratelimit
      #
      # @return [NilClass] if no ratelimit in http headers
      # @return [Integer] representing the ratelimit
      #
      def total_day
        limit? ? extract_ratelimit!(limit).last : nil
      end

      #
      # fifteen minute ratelimit used
      #
      # @return [NilClass] if no ratelimit in http headers
      # @return [Integer] representing the ratelimit
      #
      def fifteen_minutes_usage
        limit? ? extract_ratelimit!(usage).first : nil
      end

      #
      # total day ratelimit used
      #
      # @return [NilClass] if no ratelimit in http headers
      # @return [Integer] representing the ratelimit
      #
      def total_day_usage
        limit? ? extract_ratelimit!(usage).last : nil
      end

      #
      # fifteen minute ratelimit remaining
      #
      # @return [NilClass] if no ratelimit in http headers
      # @return [Integer] representing the ratelimit
      #
      def fifteen_minutes_remaining
        return nil unless fifteen_minutes && fifteen_minutes_usage

        fifteen_minutes - fifteen_minutes_usage
      end

      #
      # total day ratelimit remaining
      #
      # @return [NilClass] if no ratelimit in http headers
      # @return [Integer] representing the ratelimit
      #
      def total_day_remaining
        return nil unless total_day && total_day_usage

        total_day - total_day_usage
      end

      private

      #
      # ratelimit comes as a String of two Integers separated by comma
      #
      # @param [String] ratelimit
      #
      # @return [Array<Integer>]
      #
      def extract_ratelimit!(ratelimit)
        @lookup_table_ratelimits ||= {}
        @lookup_table_ratelimits[ratelimit] ||= ratelimit.split(',').map(&:to_i)
      end
    end
  end
end

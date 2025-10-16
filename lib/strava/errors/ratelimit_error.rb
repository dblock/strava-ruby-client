# frozen_string_literal: true

module Strava
  module Errors
    class RatelimitError < ::Faraday::ClientError
      attr_reader :ratelimit

      def initialize(env, response)
        @ratelimit = Strava::Api::Ratelimit.new(env.response)
        super(response)
      end

      def message
        response[:body]['message'] || super
      end

      def headers
        response[:headers]
      end

      def errors
        response[:body]['errors']
      end
    end
  end
end

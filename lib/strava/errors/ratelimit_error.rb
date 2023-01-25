# frozen_string_literal: true

module Strava
  module Errors
    class RatelimitError < ::Faraday::ClientError
      attr_reader :http_response, :ratelimit, :error_message

      def initialize(http_response, error_message = nil)
        @response = http_response.response
        @ratelimit = Strava::Api::Ratelimit.new(@response)
        @error_message = error_message || message
        super({
          status: http_response.status,
          headers: http_response.response_headers,
          body: http_response.body
        })
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

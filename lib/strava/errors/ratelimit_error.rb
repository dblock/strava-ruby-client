# frozen_string_literal: true

module Strava
  module Errors
    #
    # Exception raised when API rate limits are exceeded.
    #
    # Strava enforces rate limits on API requests to prevent abuse. When your
    # application exceeds these limits (either per 15 minutes or per day), the
    # API returns a 429 Too Many Requests response, which triggers this exception.
    #
    # This error includes rate limit information extracted from the response headers,
    # allowing you to determine current usage and when limits will reset.
    #
    # @see Strava::Api::Ratelimit
    # @see https://developers.strava.com/docs/rate-limits/
    #
    class RatelimitError < ::Faraday::ClientError
      # @return [Strava::Api::Ratelimit] Rate limit information from response headers
      attr_reader :ratelimit

      #
      # Initialize a new rate limit error.
      #
      # @param env [Faraday::Env] The Faraday request environment
      # @param response [Hash] The HTTP response hash
      #
      def initialize(env, response)
        @ratelimit = Strava::Api::Ratelimit.new(env.response)
        super(response)
      end

      #
      # Returns the error message from the API response.
      #
      # @return [String] The error message
      #
      def message
        response[:body]['message'] || super
      end

      #
      # Returns the HTTP response headers.
      #
      # @return [Hash] The response headers hash
      #
      def headers
        response[:headers]
      end

      #
      # Returns detailed error information from the API response.
      #
      # @return [Array, nil] Array of error details, or nil if not present
      #
      def errors
        response[:body]['errors']
      end
    end
  end
end

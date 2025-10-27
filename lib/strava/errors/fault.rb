# frozen_string_literal: true

module Strava
  module Errors
    #
    # Base error class for Strava API client errors.
    #
    # This exception is raised when the Strava API returns an error response.
    # It extends Faraday::ClientError and provides convenient access to the
    # error message, response headers, and detailed error information from
    # the API response body.
    #
    # @see Faraday::ClientError
    #
    class Fault < ::Faraday::ClientError
      #
      # Returns the error message from the API response.
      #
      # Extracts the message from the response body if available,
      # otherwise falls back to the parent class message.
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
      # The Strava API may return an 'errors' array in the response body
      # containing detailed information about validation errors or other
      # specific error conditions.
      #
      # @return [Array, nil] Array of error details, or nil if not present
      #
      def errors
        response[:body]['errors']
      end
    end
  end
end

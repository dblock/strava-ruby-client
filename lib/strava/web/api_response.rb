# frozen_string_literal: true

module Strava
  module Web
    #
    # Wraps an HTTP response with rate limit information.
    #
    # This class provides access to both the raw HTTP response and
    # parsed rate limit data from the response headers.
    #
    # @see Strava::Api::Ratelimit
    # @see Strava::Models::Mixins::HttpResponse
    #
    # @example Accessing response data
    #   activity = client.activity(1234567890)
    #   api_response = activity.http_response
    #
    #   # Access raw HTTP response
    #   status = api_response.response.status
    #   headers = api_response.response.headers
    #
    #   # Access rate limit information
    #   puts "Requests remaining: #{api_response.ratelimit.fifteen_minutes_remaining}"
    #
    class ApiResponse
      # @return [Faraday::Response] The raw HTTP response
      attr_accessor :response

      # @return [Strava::Api::Ratelimit] Rate limit information extracted from response headers
      attr_accessor :ratelimit

      #
      # Initialize a new ApiResponse with an HTTP response.
      #
      # @param http_response [Faraday::Response] HTTP response from the Strava API
      #
      def initialize(http_response)
        @response = http_response
        @ratelimit = Strava::Api::Ratelimit.new(http_response)
      end
    end
  end
end

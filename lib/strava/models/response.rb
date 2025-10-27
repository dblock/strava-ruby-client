# frozen_string_literal: true

module Strava
  module Models
    #
    # Base response model for all API responses.
    #
    # This class serves as the parent for all model classes that represent API responses.
    # It includes the HttpResponse mixin which provides access to HTTP response data
    # including rate limit information.
    #
    # Most API models inherit from this class to gain access to the http_response method,
    # which can be used to inspect rate limits and other response metadata.
    #
    # @example Accessing rate limit information
    #   activity = client.activity(1234567890)
    #   ratelimit = activity.http_response.ratelimit
    #   puts "Remaining requests: #{ratelimit.fifteen_minutes_remaining}"
    #
    # @see Mixins::HttpResponse
    # @see Strava::Api::Ratelimit
    #
    class Response < Model
      include Mixins::HttpResponse
    end
  end
end

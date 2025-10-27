# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides access to HTTP response data and rate limit information.
      #
      # This mixin is included in Response (the base class for most API models)
      # and provides access to the underlying HTTP response, which contains
      # important metadata like rate limit information.
      #
      # @example Checking rate limits
      #   activity = client.activity(1234567890)
      #   ratelimit = activity.http_response.ratelimit
      #
      #   puts "15-min limit: #{ratelimit.fifteen_minutes_limit}"
      #   puts "15-min used: #{ratelimit.fifteen_minutes_usage}"
      #   puts "15-min remaining: #{ratelimit.fifteen_minutes_remaining}"
      #
      #   puts "Daily limit: #{ratelimit.daily_limit}"
      #   puts "Daily used: #{ratelimit.daily_usage}"
      #   puts "Daily remaining: #{ratelimit.daily_remaining}"
      #
      # @see Strava::Web::ApiResponse
      # @see Strava::Api::Ratelimit
      #
      module HttpResponse
        extend ActiveSupport::Concern

        included do
          # @return [Hash] Raw input data including HTTP response
          # @api private
          attr_reader :input

          #
          # Initializes the model with input data.
          #
          # @param obj [Hash] Input data including 'http_response' key
          #
          # @api private
          #
          def initialize(obj)
            @input = obj
            super
          end

          #
          # Returns the HTTP response wrapper with rate limit information.
          #
          # @return [Strava::Web::ApiResponse] API response wrapper
          #
          def http_response
            @http_response ||= Strava::Web::ApiResponse.new(input['http_response'])
          end
        end
      end
    end
  end
end

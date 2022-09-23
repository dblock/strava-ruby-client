# frozen_string_literal: true

module Strava
  module Web
    class ApiResponse
      attr_accessor :response, :ratelimit

      def initialize(http_response)
        @response = http_response
        @ratelimit = Strava::Api::Ratelimit.new(@response)
      end
    end
  end
end

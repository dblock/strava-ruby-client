module Strava
  module Web
    class ApiResponse
      attr_accessor :response, :ratelimit

      def initialize(response)
        @response = response
        @ratelimit = Strava::Api::Ratelimit.new(@response)
      end
    end
  end
end

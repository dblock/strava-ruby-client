module Strava
  module Web
    class Response
      attr_reader :response, :headers, :body

      def initialize(response)
        @response = response
        @headers = response.headers
        @body = response.body
      end

      def ratelimit_headers
        @ratelimit_headers ||=
          Strava::Api::RatelimitHeaders.new(@headers)
      end
    end
  end
end

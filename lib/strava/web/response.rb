module Strava
  module Web
    class Response
      def initialize(header, body)
        @header = header
        @body = body
      end
    end
  end
end

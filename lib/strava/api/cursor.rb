module Strava
  module Api
    class Cursor
      include Enumerable

      attr_reader :client
      attr_reader :method
      attr_reader :params

      def initialize(client, method, params = {})
        @client = client
        @method = method
        @params = params
      end

      def each
        next_page = 1
        loop do
          query = params.merge(page: next_page)
          response = client.send(method, query)
          break unless response.any?

          yield response
          next_page += 1
        end
      end
    end
  end
end

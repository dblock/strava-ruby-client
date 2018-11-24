module Strava
  module Api
    class Cursor
      include Enumerable

      attr_reader :client
      attr_reader :path
      attr_reader :params

      def initialize(client, path, params = {})
        @client = client
        @path = path
        @params = params
      end

      def each
        next_page = 1
        loop do
          query = params.merge(page: next_page)
          response = client.get(path, query)
          break unless response.any?

          yield response
          next_page += 1
        end
      end
    end
  end
end

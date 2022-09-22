module Strava
  module Api
    #
    # Wrapper Class around pagination results which are an Array of Models.
    #
    # This class exists to provide a way to provide a high-level abstraction, like
    # access to API request/reponse data (i.e. ratelimits) for paginated results.
    #
    class Pagination
      include Enumerable

      attr_reader :collection

      def initialize(collection)
        @collection = collection
      end

      def size
        @collection.size
      end

      def each
        @collection.each { |c| yield c if block_given? }
      end

      def ratelimit
        return nil unless @collection.first

        @collection.first.ratelimit
      end

      private

      def method_missing(method_symbol, *args, &block)
        @collection.send(method_symbol, *args, &block)
      end

      def respond_to_missing?(method_name, include_private = false)
        super
      end
    end
  end
end

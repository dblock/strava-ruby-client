# frozen_string_literal: true

module Strava
  module Api
    #
    # Wrapper Class around pagination results which are an Array of Models.
    #
    # This class exists to provide a way to provide a high-level abstraction, like
    # access to API request/response data (i.e. ratelimits) for paginated results.
    #
    class Pagination
      include Enumerable
      include Strava::DeepCopyable

      attr_reader :collection, :http_response

      def initialize(collection, http_response)
        @collection = collection
        @http_response = deep_copy(http_response)
      end

      #
      # returns a Ratelimit instance
      #
      # @return [Strava::Api::Ratelimit]
      #
      def ratelimit
        Strava::Api::Ratelimit.new(@http_response.http_response)
      end

      def size
        @collection.size
      end

      def each
        @collection.each { |c| yield c if block_given? }
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

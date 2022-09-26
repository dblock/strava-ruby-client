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

      attr_reader :collection

      #
      # @param [Array<Strava::Models::>] collection of Models
      # @param [Strava::Web::Response] web_response
      #
      def initialize(collection, web_response)
        @collection = collection
        @web_response = web_response
      end

      #
      # getter method that calculates on access
      #
      # @return [Strava::Web::ApiResponse]
      #
      def http_response
        @http_response ||=
          Strava::Web::ApiResponse.new(deep_copy(@web_response).http_response)
      end

      #
      # delegates `size` to @collection
      #
      # @return [Integer]
      #
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

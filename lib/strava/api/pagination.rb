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
        @http_response ||= Strava::Web::ApiResponse.new(deep_copy(@web_response).http_response)
      end

      #
      # delegates `size` to @collection
      #
      # @return [Integer]
      #
      def size
        @collection.size
      end

      #
      # Iterates over each item in the paginated collection.
      #
      # @yield [Object] Yields each item in the collection
      # @return [void]
      #
      def each
        @collection.each { |c| yield c if block_given? }
      end

      private

      #
      # Delegates missing methods to the underlying collection.
      #
      # Allows the Pagination object to respond to array methods by
      # forwarding them to the internal collection array.
      #
      # @api private
      # @param method_symbol [Symbol] The method name to forward
      # @param args [Array] Arguments to pass to the method
      # @return [Object] Result from the delegated method
      #
      def method_missing(method_symbol, ...)
        @collection.send(method_symbol, ...)
      end

      #
      # Checks if the underlying collection responds to a method.
      #
      # @api private
      # @param method_name [Symbol] The method name to check
      # @param include_private [Boolean] Whether to include private methods
      # @return [Boolean] true if the collection responds to the method
      #
      def respond_to_missing?(method_name, include_private = false)
        super
      end
    end
  end
end

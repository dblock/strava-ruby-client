# frozen_string_literal: true

module Strava
  module Web
    #
    # Wraps a Faraday response from the Strava API.
    #
    # Each Hash in the response body is copied with an added `http_response` key,
    # so models can access the response, e.g. for rate limits, without mutating
    # or deep copying the original response.
    #
    class Response
      attr_reader :http_response, :response

      #
      # @param [Faraday::Response] http_response
      #
      def initialize(http_response)
        @http_response = http_response
        @response = upgrade_response(http_response)
      end

      private

      #
      # @param [Faraday::Response] http_response
      #
      # @return [Array<Hash>, Faraday::Response, Object] rows of an Array body,
      #   a copy of the response with a Hash body, or any other body
      #
      def upgrade_response(http_response)
        case (body = http_response.body)
        when Array
          body.map { |row| (row || {}).merge('http_response' => http_response) }
        when Hash
          env = http_response.env.dup
          env.body = body.merge('http_response' => http_response)
          Faraday::Response.new(env)
        else
          body
        end
      end

      #
      # @param [Symbol] method_symbol
      # @param [any] *args
      # @param [Proc] &block
      #
      # @raise [NoMethodError]
      # @return [any]
      #
      def operate_on_response_body!(method_symbol, ...)
        case @response.body
        when Hash
          @response.body.send(method_symbol, ...)
        else
          raise NoMethodError
        end
      end

      #
      # Delegates missing methods to the response body or array.
      #
      # If the response is an array, delegates methods to the array.
      # Otherwise, delegates to the response body hash, allowing access
      # to response fields as if they were methods.
      #
      # @param method_symbol [Symbol] The method name to forward
      # @param args [Array] Arguments to pass to the method
      # @return [Object] Result from the delegated method
      #
      def method_missing(method_symbol, ...)
        case @response
        when Array
          @response.send(method_symbol, ...)
        else
          operate_on_response_body!(method_symbol, ...)
        end
      end

      #
      # Checks if the response body or array responds to a method.
      #
      # @param method_name [Symbol] The method name to check
      # @param include_private [Boolean] Whether to include private methods
      # @return [Boolean] true if the response responds to the method
      #
      def respond_to_missing?(method_name, include_private = false)
        super
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Web
    #
    # wrapper class as abstraction for API response returned from the Faraday Adapter
    # working with a deep copy, in order to not mutate the original request itself
    #
    class Response
      include Strava::DeepCopyable

      attr_reader :http_response, :response

      #
      # @param [Faraday::Response] http_response
      #
      def initialize(http_response)
        @http_response = deep_copy(http_response)
        @response = conditional_response_upgrade!(http_response)
      end

      private

      #
      # returns a modified deep copy of the Faraday::Response
      #
      # @param [Faraday::Response] http_response
      #
      # @return [Array, Hash{String => any}]
      #
      def conditional_response_upgrade!(http_response)
        response = deep_copy(http_response)

        case response.body
        when Array
          upgrade_array_body!(response)
        when Hash
          response.body['http_response'] = response
        else
          response.body
        end
      end

      #
      # mutates the response when body is_a? Hash
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
      # mutates all responses in the body
      #
      # @param [Faraday::Response] response from the Strava API
      #
      # @return [Array<Faraday::Response>]
      #
      def upgrade_array_body!(response)
        response.body.map! do |body_elem|
          body_elem ||= {}
          body_elem['http_response'] = response
          body_elem
        end
      end

      def method_missing(method_symbol, ...)
        case @response
        when Array
          @response.send(method_symbol, ...)
        else
          operate_on_response_body!(method_symbol, ...)
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        super
      end
    end
  end
end

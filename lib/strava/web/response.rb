# frozen_string_literal: true

module Strava
  module Web
    class Response
      attr_accessor :response

      def initialize(response)
        @response = response
      end

      def body
        @response.body
      end

      def headers
        @response.headers
      end

      private

      def method_missing(method_symbol, *args, &block)
        case @response
        when Array
          @response.send(method_symbol, *args, &block)
        else
          operate_on_response_body!(method_symbol, *args, &block)
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        super
      end

      def operate_on_response_body!(method_symbol, *args, &block)
        case @response.body
        when Hash
          @response.body.send(method_symbol, *args, &block)
        else
          raise NoMethodError
        end
      end
    end
  end
end

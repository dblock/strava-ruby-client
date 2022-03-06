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

      def method_missing(method_symbol, *args, &block)
        if @response.instance_of?(Array)
          @response.send(method_symbol, *args, &block)
        else
          case @response.body
          when Array
            @response.body.map do |elem|
              elem.send(method_symbol, *args, &block)
            end
          when Hash
            @response.body.send(method_symbol, *args, &block)
          else
            raise NoMethodError
          end
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        super
      end
    end
  end
end

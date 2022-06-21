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

      # rubocop:disable Style/MissingRespondToMissing
      def method_missing(method_symbol, *args, &block)
        if @response.instance_of?(Array)
          @response.send(method_symbol, *args, &block)
        else
          if @response.body.is_a?(Array)
            @response.body.map do |elem|
              elem.send(method_symbol, *args, &block)
            end
          elsif @response.body.is_a?(Hash)
            @response.body.send(method_symbol, *args, &block)
          else
            raise NoMethodError
          end
        end
      end
      # rubocop:enable Style/MissingRespondToMissing
    end
  end
end

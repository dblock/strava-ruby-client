module Strava
  module Web
    class ResponseWrap
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
          case @response.body.class.name
          when 'Array'
            @response.body.map do |elem|
              elem.send(method_symbol, *args, &block)
            end
          when 'Hash'
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

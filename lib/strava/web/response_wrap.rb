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

      # rubocop:disable Style/MethodMissingSuper, Style/MissingRespondToMissing
      def method_missing(m, *args, &block)
        if @response.class.name == 'Array'
          @response.send(m, *args, &block)
        else
          case @response.body.class.name
          when 'Array'
            @response.body.map do |elem|
              elem.send(m, *args, &block)
            end
          when 'Hash'
            @response.body.send(m, *args, &block)
          else
            raise NoMethodError
          end
        end
      end
      # rubocop:enable Style/MethodMissingSuper, Style/MissingRespondToMissing
    end
  end
end

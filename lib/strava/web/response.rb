module Strava
  module Web
    module Response
      def extract_response!(response)
        extract_ratelimit!(response)
      end

      def extract_ratelimit!(response)
        return response unless response.body.present?

        case response.body.class.name
        when 'Array'
          response.body.map! do |elem|
            merge_ratelimit!(elem, response)
          end
        when 'Hash'
          elem = response.body
          merge_ratelimit!(elem, response)
        else
          response
        end
      end

      private

      def merge_ratelimit!(elem, response)
        elem.merge!(Strava::Api::Ratelimit.new(response.headers).ratelimit_hash)
      end
    end
  end
end

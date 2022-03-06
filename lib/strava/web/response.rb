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
            elem.merge! Strava::Api::Ratelimit.new(response.headers).ratelimit_hash
          end
        when 'Hash'
          response.body.merge! Strava::Api::Ratelimit.new(response.headers).ratelimit_hash
        else
          response
        end
      end
    end
  end
end

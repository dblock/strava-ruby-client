# frozen_string_literal: true

module Strava
  module Web
    module Response
      class RaiseError < ::Faraday::Middleware
        CLIENT_ERROR_STATUSES = (400...600).freeze

        def on_complete(env)
          case env[:status]
          when 404
            raise Faraday::ResourceNotFound, response_values(env)
          when 407
            # mimic the behavior that we get with proxy requests with HTTPS
            raise Faraday::ConnectionFailed, %(407 "Proxy Authentication Required ")
          when CLIENT_ERROR_STATUSES
            raise Strava::Errors::Fault, response_values(env)
          end
        end

        def response_values(env)
          {
            status: env.status,
            headers: env.response_headers,
            body: env.body
          }
        end
      end
    end
  end
end

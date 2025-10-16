# frozen_string_literal: true

module Strava
  module Web
    class RaiseResponseError < ::Faraday::Middleware
      DEFAULT_OPTIONS = Faraday::Response::RaiseError::DEFAULT_OPTIONS
      CLIENT_ERROR_STATUSES = (400...600)

      def on_complete(env)
        case env[:status]
        when 404
          raise Faraday::ResourceNotFound, response_values(env)
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise Faraday::ConnectionFailed, %(407 "Proxy Authentication Required ")
        when 429
          raise Strava::Errors::RatelimitError.new(env, response_values(env))
        when CLIENT_ERROR_STATUSES
          raise Strava::Errors::Fault, response_values(env)
        end
      end

      def response_values(env)
        response = {
          status: env.status,
          headers: env.response_headers,
          body: env.body
        }

        # Include the request data by default. If the middleware was explicitly
        # configured to _not_ include request data, then omit it.
        return response unless options[:include_request]

        response.merge(
          request: {
            method: env.method,
            url: env.url,
            url_path: env.url.path,
            params: query_params(env),
            headers: env.request_headers,
            body: env.request_body
          }
        )
      end

      def query_params(env)
        env.request.params_encoder ||= Faraday::Utils.default_params_encoder
        env.params_encoder.decode(env.url.query)
      end
    end
  end
end

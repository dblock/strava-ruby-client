# frozen_string_literal: true

module Strava
  module Web
    #
    # Faraday middleware that raises exceptions for HTTP error responses.
    #
    # This middleware intercepts HTTP responses and raises appropriate exceptions
    # based on the status code. It handles common HTTP error statuses and maps them
    # to specific Strava error classes, including special handling for rate limiting
    # (429) and resource not found (404) responses.
    #
    # @see Faraday::Middleware
    # @see Strava::Errors::Fault
    # @see Strava::Errors::RatelimitError
    #
    class RaiseResponseError < ::Faraday::Middleware
      # @return [Hash] Default options inherited from Faraday's RaiseError middleware
      DEFAULT_OPTIONS = Faraday::Response::RaiseError::DEFAULT_OPTIONS

      # @return [Range] HTTP status codes that are considered client errors (400-599)
      CLIENT_ERROR_STATUSES = (400...600)

      #
      # Callback invoked when an HTTP response is complete.
      #
      # Examines the HTTP status code and raises appropriate exceptions:
      # - 404: Faraday::ResourceNotFound
      # - 407: Faraday::ConnectionFailed (proxy authentication required)
      # - 429: Strava::Errors::RatelimitError (rate limit exceeded)
      # - 400-599: Strava::Errors::Fault (general client/server errors)
      #
      # @param env [Faraday::Env] The Faraday request/response environment
      # @raise [Faraday::ResourceNotFound] When resource is not found (404)
      # @raise [Faraday::ConnectionFailed] When proxy authentication fails (407)
      # @raise [Strava::Errors::RatelimitError] When rate limit is exceeded (429)
      # @raise [Strava::Errors::Fault] For other client/server errors (400-599)
      # @return [void]
      #
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

      #
      # Extracts response values from the Faraday environment.
      #
      # Builds a hash containing response information (status, headers, body)
      # and optionally includes request details if the middleware is configured
      # with `include_request: true`.
      #
      # @param env [Faraday::Env] The Faraday request/response environment
      # @return [Hash] Response values including status, headers, body, and optionally request details
      #
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

      #
      # Extracts and decodes query parameters from the request URL.
      #
      # @param env [Faraday::Env] The Faraday request/response environment
      # @return [Hash] Decoded query parameters
      #
      def query_params(env)
        env.request.params_encoder ||= Faraday::Utils.default_params_encoder
        env.params_encoder.decode(env.url.query)
      end
    end
  end
end

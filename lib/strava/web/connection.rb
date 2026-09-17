# frozen_string_literal: true

module Strava
  module Web
    #
    # HTTP connection management for Strava web clients.
    #
    # This module provides connection handling and configuration for making HTTP
    # requests to Strava APIs. It sets up a Faraday connection with proper headers,
    # middleware, SSL configuration, and timeout settings.
    #
    # The connection is configured with:
    # - JSON request and response handling
    # - Automatic error raising for failed responses
    # - Optional logging
    # - SSL certificate validation
    # - Request timeouts
    #
    # @api private
    #
    module Connection
      private

      #
      # Returns HTTP headers to be included in requests.
      #
      # This method can be overridden in including classes to provide
      # custom headers (e.g., authentication headers).
      #
      # @api private
      # @return [Hash] HTTP headers hash
      #
      def headers
        {}
      end

      #
      # Establishes and returns a Faraday HTTP connection.
      #
      # Creates a memoized Faraday connection configured with:
      # - Base endpoint URL
      # - Custom headers including Accept and User-Agent
      # - Proxy settings if configured
      # - SSL certificate paths
      # - Request timeouts
      # - Middleware stack for multipart, URL encoding, error handling, and JSON parsing
      #
      # @api private
      # @return [Faraday::Connection] Configured Faraday connection instance
      #
      def connection
        @connection ||= begin
          options = {
            headers: headers.merge('Accept' => 'application/json; charset=utf-8')
          }

          options[:headers]['User-Agent'] = user_agent if user_agent
          options[:proxy] = proxy if proxy
          options[:ssl] = { ca_path: ca_path, ca_file: ca_file } if ca_path || ca_file

          request_options = {}
          request_options[:timeout] = timeout if timeout
          request_options[:open_timeout] = open_timeout if open_timeout
          options[:request] = request_options if request_options.any?

          ::Faraday::Connection.new(endpoint, options) do |connection|
            connection.request :multipart
            connection.request :url_encoded
            connection.use Strava::Web::RaiseResponseError
            connection.response :json
            connection.response :logger, logger if logger
            connection.adapter ::Faraday.default_adapter
          end
        end
      end
    end
  end
end

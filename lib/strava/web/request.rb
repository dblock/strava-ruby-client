# frozen_string_literal: true

module Strava
  module Web
    #
    # HTTP request methods for Strava web clients.
    #
    # This module provides GET, POST, PUT, and DELETE HTTP methods for making
    # requests to Strava APIs. All methods return a wrapped response object
    # that provides easy access to response data and metadata.
    #
    # @api private
    #
    module Request
      #
      # Perform an HTTP GET request.
      #
      # @param path [String] The API path (relative to endpoint)
      # @param options [Hash] Query parameters and options
      #
      # @return [Strava::Web::Response] Wrapped HTTP response
      #
      def get(path, options = {})
        request(:get, path, options)
      end

      #
      # Perform an HTTP POST request.
      #
      # @param path [String] The API path (relative to endpoint)
      # @param options [Hash] Request body parameters and options
      #
      # @return [Strava::Web::Response] Wrapped HTTP response
      #
      def post(path, options = {})
        request(:post, path, options)
      end

      #
      # Perform an HTTP PUT request.
      #
      # @param path [String] The API path (relative to endpoint)
      # @param options [Hash] Request body parameters and options
      #
      # @return [Strava::Web::Response] Wrapped HTTP response
      #
      def put(path, options = {})
        request(:put, path, options)
      end

      #
      # Perform an HTTP DELETE request.
      #
      # @param path [String] The API path (relative to endpoint)
      # @param options [Hash] Query parameters and options
      #
      # @return [Strava::Web::Response] Wrapped HTTP response
      #
      def delete(path, options = {})
        request(:delete, path, options)
      end

      private

      #
      # Executes an HTTP request with the specified method.
      #
      # Constructs the full URL from the endpoint and path, sends the request
      # using Faraday, and wraps the response in a Strava::Web::Response object.
      #
      # @api private
      # @param method [Symbol] HTTP method (:get, :post, :put, :delete)
      # @param path [String] The API path (relative to endpoint)
      # @param options [Hash] Request parameters and options
      # @option options [String] :endpoint Override the default endpoint URL
      # @option options [Hash] :request Faraday request options (timeouts, etc.)
      #
      # @return [Strava::Web::Response] Wrapped HTTP response
      #
      def request(method, path, options)
        options = options.dup if options.key?(:request) || options.key?(:endpoint)
        root = options.delete(:endpoint) || endpoint
        path = [root, path].join('/')
        http_response = connection.send(method) do |request|
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options unless options.empty?
          end
          request.options.merge!(options.delete(:request)) if options.key?(:request)
        end

        Strava::Web::Response.new(http_response)
      end
    end
  end
end

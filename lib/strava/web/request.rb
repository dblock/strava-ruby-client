# frozen_string_literal: true

module Strava
  module Web
    module Request
      def get(path, options = {})
        request(:get, path, options)
      end

      def post(path, options = {})
        request(:post, path, options)
      end

      def put(path, options = {})
        request(:put, path, options)
      end

      def delete(path, options = {})
        request(:delete, path, options)
      end

      private

      def request(method, path, options)
        options = options.dup if options.key?(:request) || options.key?(:endpoint)
        root = options.delete(:endpoint) || endpoint
        path = [root, path].join('/')
        response = connection.send(method) do |request|
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options unless options.empty?
          end
          request.options.merge!(options.delete(:request)) if options.key?(:request)
        end

        Strava::Web::Response.new(conditional_response_upgrade(response))
      end

      #
      # Ruby's way of creating a true deep copy/clone
      #
      # @param [Object] obj of any kind
      #
      # @return [Object] deep clone of what was passed into
      #
      def deep_copy(obj)
        Marshal.load(Marshal.dump(obj))
      end

      #
      # returns a modified deep copy of the Faraday::Response
      #
      # @param [Faraday::Response] response_
      #
      # @return [Array, Hash{String => any}]
      #
      def conditional_response_upgrade(response_)
        response = deep_copy(response_)

        case response.body
        when Array
          response.body.map! do |body_elem|
            body_elem ||= {}
            body_elem['http_response'] = response
            body_elem
          end
        when Hash
          response.body['http_response'] = response
        else
          response.body
        end
      end
    end
  end
end

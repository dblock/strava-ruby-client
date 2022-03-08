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

        Strava::Web::ResponseWrap.new(conditional_response_upgrade(response))
      end

      def conditional_response_upgrade(response)
        case response.body.class.name
        when 'Array'
          response.dup.body.map! do |body_elem|
            body_elem ||= {}
            body_elem['http_response'] = response
            body_elem
          end
        when 'Hash'
          response.dup.body['http_response'] = response
        else
          response.dup.body
        end
      end
    end
  end
end

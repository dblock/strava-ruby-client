# frozen_string_literal: true

module Strava
  module Web
    module Connection
      private

      def headers
        {}
      end

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
            connection.use ::Strava::Web::Response::RaiseError
            connection.response :json
            connection.response :logger, logger if logger
            connection.adapter ::Faraday.default_adapter
          end
        end
      end
    end
  end
end

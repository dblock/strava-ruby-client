# frozen_string_literal: true

module Strava
  module Web
    #
    # Filters credentials, such as client secrets and tokens, out of request
    # data that is logged or included in errors.
    #
    module Filter
      extend self

      # @return [String] Replacement for filtered values
      FILTERED = 'FILTERED'

      # @return [Array<String>] Names of parameters that contain credentials
      PARAMS = %w[client_secret access_token refresh_token code].freeze

      # @return [Regexp] Matches credential parameters in URLs, query strings and form bodies
      PARAMS_PATTERN = /(\b(?:#{PARAMS.join('|')})=)[^&\s"]+/

      # @return [Regexp] Matches an Authorization header value in logs
      AUTHORIZATION_PATTERN = /(Authorization: "?(?:Bearer|Basic) )[^"\s]+/i

      #
      # Configures a Faraday logging formatter to filter credentials.
      #
      # @param formatter [Faraday::Logging::Formatter]
      # @return [void]
      #
      def logger(formatter)
        formatter.filter(PARAMS_PATTERN, "\\1#{FILTERED}")
        formatter.filter(AUTHORIZATION_PATTERN, "\\1#{FILTERED}")
      end

      #
      # @param value [String, URI, nil] URL, query string or form body
      # @return [String, nil] value with credential parameters filtered
      #
      def string(value)
        value&.to_s&.gsub(PARAMS_PATTERN, "\\1#{FILTERED}")
      end

      #
      # @param params [Hash, nil] request parameters
      # @return [Hash, nil] params with credential values filtered
      #
      def params(params)
        params&.to_h { |key, value| [key, PARAMS.include?(key.to_s) ? FILTERED : value] }
      end

      #
      # @param headers [Hash, nil] request headers
      # @return [Hash, nil] headers with the Authorization value filtered
      #
      def headers(headers)
        headers&.to_h { |key, value| [key, key.to_s.casecmp?('Authorization') ? FILTERED : value] }
      end

      #
      # @param body [String, Hash, Object, nil] request body
      # @return [String, Hash, Object, nil] body with credential values filtered
      #
      def body(body)
        case body
        when String then string(body)
        when Hash then params(body)
        else body
        end
      end
    end
  end
end

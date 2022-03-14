# frozen_string_literal: true

module Strava
  module OAuth
    class Client < Strava::Web::Client
      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        Strava::OAuth::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::OAuth.config.send(key))
        end
        super
      end

      #
      # Obtain the request access URL.
      #
      # @option options [Object] :redirect_uri
      #   URL to which the user will be redirected after authentication.
      # @option options [Object] :response_type
      #   Must be code.
      # @option options [Object] :approval_prompt
      #   Prompt behavior, force or auto.
      # @option options [Object] :scope
      #   Requested scopes, as a comma delimited string.
      # @option options [Object] :state
      #   Returned in the redirect URI.
      # @see https://developers.strava.com/docs/authentication/
      # @return [String] URL to redirect the user to.
      def authorize_url(options = {})
        query = options.merge(
          client_id: client_id || raise(ArgumentError, 'Missing Strava client id.'),
          response_type: options[:response_type] || 'code',
          redirect_uri: options[:redirect_uri] || 'http://localhost',
          approval_prompt: options[:approval_prompt] || 'auto',
          scope: options[:scope] || 'read'
        )

        [endpoint, "authorize?#{query.to_query}"].join('/')
      end

      #
      # Complete the authentication process.
      #
      # @option options [Object] :code
      #   The code parameter obtained in the redirect.
      # @option options [Object] :grant_type
      #   The grant type for the request.
      # @see https://developers.strava.com/docs/authentication/
      # @return [Hash] Token information.
      def oauth_token(options = {})
        query = options.merge(
          client_id: client_id || raise(ArgumentError, 'Missing Strava client id.'),
          client_secret: client_secret || raise(ArgumentError, 'Missing Strava client secret.'),
          grant_type: options[:grant_type] || 'authorization_code'
        )

        Strava::Models::Token.new(post('token', query))
      end

      class << self
        def configure
          block_given? ? yield(Config) : Config
        end

        def config
          Config
        end
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module OAuth
    #
    # OAuth client for Strava authentication.
    #
    # This client handles the OAuth 2.0 authentication flow with Strava, including:
    # * Generating authorization URLs
    # * Exchanging authorization codes for access tokens
    # * Refreshing expired access tokens
    #
    # @example Basic OAuth flow
    #   client = Strava::OAuth::Client.new(
    #     client_id: "your_client_id",
    #     client_secret: "your_client_secret"
    #   )
    #
    #   # Step 1: Get authorization URL
    #   url = client.authorize_url(
    #     redirect_uri: 'http://localhost:3000/callback',
    #     scope: 'read,activity:read_all'
    #   )
    #   # Redirect user to this URL
    #
    #   # Step 2: Exchange code for token
    #   token = client.oauth_token(code: params[:code])
    #   # Store token.access_token and token.refresh_token
    #
    #   # Step 3: Refresh token when expired
    #   new_token = client.oauth_token(
    #     refresh_token: saved_refresh_token,
    #     grant_type: 'refresh_token'
    #   )
    #
    # @see https://developers.strava.com/docs/authentication/
    #
    class Client < Strava::Web::Client
      attr_accessor(*Config::ATTRIBUTES)

      #
      # Initialize a new OAuth client.
      #
      # @param [Hash] options Configuration options
      # @option options [String] :client_id Strava application client ID (required)
      # @option options [String] :client_secret Strava application client secret (required)
      # @option options [String] :endpoint OAuth endpoint URL (defaults to https://www.strava.com/oauth)
      #
      def initialize(options = {})
        Strava::OAuth::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::OAuth.config.send(key))
        end
        super
      end

      #
      # Generate the authorization URL for OAuth flow.
      #
      # Creates a URL to redirect users to for Strava authorization. After the user
      # authorizes your application, they will be redirected back to your redirect_uri
      # with an authorization code.
      #
      # @param [Hash] options Authorization parameters
      # @option options [String] :redirect_uri URL where user is redirected after authorization (default: http://localhost)
      # @option options [String] :response_type Must be 'code' (default: 'code')
      # @option options [String] :approval_prompt 'force' to always show approval page, 'auto' to auto-approve (default: 'auto')
      # @option options [String] :scope Comma-delimited string of permissions (default: 'read')
      #   Available scopes: read, read_all, profile:read_all, profile:write, activity:read, activity:read_all, activity:write
      # @option options [String] :state Optional value returned in redirect URI for CSRF protection
      #
      # @return [String] Full authorization URL
      #
      # @example Generate authorization URL
      #   url = client.authorize_url(
      #     redirect_uri: 'https://myapp.com/callback',
      #     scope: 'read,activity:read_all,activity:write',
      #     state: 'random_state_value'
      #   )
      #
      # @see https://developers.strava.com/docs/authentication/
      #
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
      # Exchange authorization code for access token or refresh an expired token.
      #
      # This method handles two OAuth flows:
      # 1. Initial token exchange: Exchange authorization code for access/refresh tokens
      # 2. Token refresh: Use refresh_token to get new access/refresh tokens
      #
      # @param [Hash] options Token request parameters
      # @option options [String] :code Authorization code from redirect (for initial exchange)
      # @option options [String] :refresh_token Refresh token (for token refresh)
      # @option options [String] :grant_type Grant type: 'authorization_code' (default) or 'refresh_token'
      #
      # @return [Strava::Models::Token] Token object with access_token, refresh_token, expires_at, and athlete
      #
      # @example Exchange authorization code for token
      #   token = client.oauth_token(code: 'authorization_code_from_redirect')
      #   access_token = token.access_token
      #   refresh_token = token.refresh_token
      #   expires_at = token.expires_at
      #
      # @example Refresh an expired token
      #   new_token = client.oauth_token(
      #     refresh_token: 'saved_refresh_token',
      #     grant_type: 'refresh_token'
      #   )
      #
      # @see https://developers.strava.com/docs/authentication/
      #
      def oauth_token(options = {})
        query = options.merge(
          client_id: client_id || raise(ArgumentError, 'Missing Strava client id.'),
          client_secret: client_secret || raise(ArgumentError, 'Missing Strava client secret.'),
          grant_type: options[:grant_type] || 'authorization_code'
        )

        Strava::Models::Token.new(post('token', query))
      end

      class << self
        #
        # Configure the OAuth client with a block.
        #
        # @yield [Config] Yields the configuration module for setup
        # @return [Module] The Config module
        #
        # @example
        #   Strava::OAuth::Client.configure do |config|
        #     config.client_id = ENV['STRAVA_CLIENT_ID']
        #     config.client_secret = ENV['STRAVA_CLIENT_SECRET']
        #   end
        #
        def configure
          block_given? ? yield(Config) : Config
        end

        #
        # Returns the current OAuth client configuration.
        #
        # @return [Module] The Config module
        #
        def config
          Config
        end
      end
    end
  end
end

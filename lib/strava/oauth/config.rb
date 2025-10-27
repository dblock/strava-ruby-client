# frozen_string_literal: true

module Strava
  module OAuth
    #
    # Configuration module for the OAuth client.
    #
    # This module manages OAuth-specific configuration settings including the
    # OAuth endpoint URL and application credentials (client ID and secret)
    # required for token exchange and refresh operations.
    #
    # @example Configure OAuth client
    #   Strava::OAuth.configure do |config|
    #     config.client_id = ENV['STRAVA_CLIENT_ID']
    #     config.client_secret = ENV['STRAVA_CLIENT_SECRET']
    #   end
    #
    # @see https://developers.strava.com/docs/authentication/
    #
    module Config
      extend self

      # @return [Array<Symbol>] List of configurable OAuth attributes
      ATTRIBUTES = %i[
        endpoint
        client_id
        client_secret
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      #
      # Reset configuration to default values.
      #
      # Sets the endpoint to the default Strava OAuth URL and clears
      # the client credentials.
      #
      # @return [void]
      #
      def reset
        self.endpoint = 'https://www.strava.com/oauth'
        self.client_id = nil
        self.client_secret = nil
      end
    end

    class << self
      #
      # Configure the OAuth client with a block.
      #
      # @yield [Config] Yields the configuration module for setup
      # @return [Module] The Config module
      #
      # @example
      #   Strava::OAuth.configure do |config|
      #     config.client_id = '12345'
      #     config.client_secret = 'your_client_secret'
      #   end
      #
      def configure
        block_given? ? yield(Config) : Config
      end

      #
      # Returns the current OAuth configuration.
      #
      # @return [Module] The Config module
      #
      def config
        Config
      end
    end
  end
end

Strava::OAuth::Config.reset

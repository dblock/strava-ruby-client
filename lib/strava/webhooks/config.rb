# frozen_string_literal: true

module Strava
  module Webhooks
    #
    # Configuration module for the Webhooks client.
    #
    # This module manages webhook-specific configuration settings including the
    # API endpoint URL and application credentials (client ID and secret) required
    # for managing webhook subscriptions.
    #
    # Webhooks allow your application to receive real-time notifications when
    # athletes create new activities or update their profile information.
    #
    # @example Configure Webhooks client
    #   Strava::Webhooks.configure do |config|
    #     config.client_id = ENV['STRAVA_CLIENT_ID']
    #     config.client_secret = ENV['STRAVA_CLIENT_SECRET']
    #   end
    #
    # @see https://developers.strava.com/docs/webhooks/
    #
    module Config
      extend self

      # @return [Array<Symbol>] List of configurable webhook attributes
      ATTRIBUTES = %i[
        endpoint
        client_id
        client_secret
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      #
      # Reset configuration to default values.
      #
      # Sets the endpoint to the default Strava API v3 URL and clears
      # the client credentials.
      #
      # @return [void]
      #
      def reset
        self.endpoint = 'https://www.strava.com/api/v3'
        self.client_id = nil
        self.client_secret = nil
      end
    end

    class << self
      #
      # Configure the Webhooks client with a block.
      #
      # @yield [Config] Yields the configuration module for setup
      # @return [Module] The Config module
      #
      # @example
      #   Strava::Webhooks.configure do |config|
      #     config.client_id = '12345'
      #     config.client_secret = 'your_client_secret'
      #   end
      #
      def configure
        block_given? ? yield(Config) : Config
      end

      #
      # Returns the current Webhooks configuration.
      #
      # @return [Module] The Config module
      #
      def config
        Config
      end
    end
  end
end

Strava::Webhooks::Config.reset

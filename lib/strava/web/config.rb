# frozen_string_literal: true

module Strava
  module Web
    #
    # Configuration module for web client HTTP settings.
    #
    # This module manages HTTP-related configuration settings shared across
    # all Strava web clients (API, OAuth, Webhooks), including proxy settings,
    # SSL certificate validation, timeouts, and logging.
    #
    # @example Configure web client settings
    #   Strava::Web.configure do |config|
    #     config.user_agent = 'MyApp/1.0'
    #     config.timeout = 30
    #     config.logger = Logger.new(STDOUT)
    #   end
    #
    module Config
      extend self

      # @return [Array<Symbol>] List of configurable HTTP attributes
      ATTRIBUTES = %i[
        proxy
        user_agent
        ca_path
        ca_file
        logger
        timeout
        open_timeout
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      #
      # Reset configuration to default values.
      #
      # Sets the user agent to the default client identifier and clears
      # all optional settings (proxy, SSL certificates, timeouts, logger).
      #
      # @return [void]
      #
      def reset
        self.user_agent = "Strava Ruby Client/#{Strava::VERSION}"
        self.ca_path = nil
        self.ca_file = nil
        self.proxy = nil
        self.logger = nil
        self.timeout = nil
        self.open_timeout = nil
      end
    end

    class << self
      #
      # Configure the web client with a block.
      #
      # @yield [Config] Yields the configuration module for setup
      # @return [Module] The Config module
      #
      # @example
      #   Strava::Web.configure do |config|
      #     config.proxy = 'http://proxy.example.com:8080'
      #     config.ca_file = '/path/to/ca-bundle.crt'
      #   end
      #
      def configure
        block_given? ? yield(Config) : Config
      end

      #
      # Returns the current web client configuration.
      #
      # @return [Module] The Config module
      #
      def config
        Config
      end
    end
  end
end

Strava::Web::Config.reset

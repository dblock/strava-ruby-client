# frozen_string_literal: true

module Strava
  module Api
    #
    # Configuration module for the Strava API client.
    #
    # This module manages configuration settings for the API client, including
    # the API endpoint URL and access token for authentication.
    #
    # @example Configure the API client
    #   Strava::Api.configure do |config|
    #     config.access_token = 'your_access_token_here'
    #   end
    #
    # @example Access current configuration
    #   Strava::Api.config.endpoint
    #   # => 'https://www.strava.com/api/v3'
    #
    module Config
      extend self

      # @return [Array<Symbol>] List of configurable attributes
      ATTRIBUTES = %i[
        endpoint
        access_token
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      #
      # Reset configuration to default values.
      #
      # Sets the endpoint to the default Strava API v3 URL and
      # clears the access token.
      #
      # @return [void]
      #
      def reset
        self.endpoint = 'https://www.strava.com/api/v3'
        self.access_token = nil
      end
    end

    class << self
      #
      # Configure the API client with a block.
      #
      # @yield [Config] Yields the configuration module for setup
      # @return [Module] The Config module
      #
      # @example
      #   Strava::Api.configure do |config|
      #     config.access_token = ENV['STRAVA_ACCESS_TOKEN']
      #   end
      #
      def configure
        block_given? ? yield(Config) : Config
      end

      #
      # Returns the current API configuration.
      #
      # @return [Module] The Config module
      #
      def config
        Config
      end
    end
  end
end

Strava::Api::Config.reset

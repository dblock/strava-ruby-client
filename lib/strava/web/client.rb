# frozen_string_literal: true

module Strava
  module Web
    #
    # Base web client class for making HTTP requests to Strava APIs.
    #
    # This class provides the foundation for all Strava client implementations
    # (API, OAuth, and Webhooks clients). It handles HTTP connection management,
    # request execution, and configuration management.
    #
    # The client includes mixins for connection handling and HTTP request methods,
    # and manages configuration attributes like endpoint URLs, user agents, and
    # authentication tokens.
    #
    # @see Strava::Web::Connection
    # @see Strava::Web::Request
    #
    class Client
      include Strava::Web::Connection
      include Strava::Web::Request

      attr_accessor(*Config::ATTRIBUTES)

      #
      # Initialize a new client instance.
      #
      # @param options [Hash] Configuration options for the client
      # @option options [String] :endpoint The API endpoint URL
      # @option options [String] :user_agent The user agent string
      # @option options [String] :token The access token for authentication
      # @option options [Logger] :logger Custom logger instance
      #
      def initialize(options = {})
        Strava::Web::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Web.config.send(key))
        end
        @logger ||= Strava::Logger.logger
      end

      #
      # Returns the API endpoint URL for this client.
      #
      # @note This method must be implemented by subclasses
      # @raise [NotImplementedError] if not implemented by subclass
      # @return [String] The API endpoint URL
      #
      def endpoint
        raise NotImplementedError
      end

      class << self
        #
        # Configure the client with a block or return the configuration.
        #
        # @yield [Config] Yields the configuration module for setup
        # @return [Module] The Config module
        #
        # @example Configure the client
        #   Strava::Web::Client.configure do |config|
        #     config.endpoint = 'https://www.strava.com/api/v3'
        #   end
        #
        def configure
          block_given? ? yield(Config) : Config
        end

        #
        # Returns the current configuration.
        #
        # @return [Module] The Config module
        #
        def config
          Config
        end
      end

      #
      # Parse method arguments that can be either (id, options) or (options).
      #
      # This helper method standardizes the common pattern where Strava API methods
      # accept either a resource ID as the first parameter followed by an options hash,
      # or just an options hash containing an :id key.
      #
      # @param id_or_options [String, Integer, Hash] Either a resource ID or options hash
      # @param options [Hash] Options hash (when first param is an ID)
      #
      # @raise [ArgumentError] if the :id is missing from the options hash
      #
      # @return [Array<(String, Hash)>] Tuple of [id, options]
      #
      # @example With separate ID and options
      #   parse_args('12345', {per_page: 10})
      #   # => ['12345', {per_page: 10}]
      #
      # @example With ID in options hash
      #   parse_args({id: '12345', per_page: 10})
      #   # => ['12345', {per_page: 10}]
      #
      def parse_args(id_or_options, options = {})
        if id_or_options.is_a?(Hash)
          throw ArgumentError.new('Required argument :id missing') if id_or_options[:id].nil?
          [id_or_options[:id], id_or_options.except(:id)]
        else
          throw ArgumentError.new('Required argument :id missing') if id_or_options.nil?
          [id_or_options, options]
        end
      end
    end
  end
end

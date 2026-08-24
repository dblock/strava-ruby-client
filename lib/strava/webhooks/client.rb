# frozen_string_literal: true

module Strava
  module Webhooks
    #
    # Webhooks client for Strava push subscriptions.
    #
    # Strava provides webhooks for receiving real-time updates about athlete activities
    # and other events. This client manages webhook subscriptions (create, list, delete).
    #
    # Before creating a subscription, you must implement an HTTP endpoint that:
    # 1. Handles GET requests for subscription validation (Challenge)
    # 2. Handles POST requests for webhook events (Event)
    #
    # @example Create and manage a webhook subscription
    #   client = Strava::Webhooks::Client.new(
    #     client_id: "your_client_id",
    #     client_secret: "your_client_secret"
    #   )
    #
    #   # Create subscription
    #   subscription = client.create_push_subscription(
    #     callback_url: 'https://myapp.com/strava/webhook',
    #     verify_token: 'my_verify_token'
    #   )
    #
    #   # List subscriptions
    #   subscriptions = client.push_subscriptions
    #
    #   # Delete subscription
    #   client.delete_push_subscription(subscription.id)
    #
    # @see https://developers.strava.com/docs/webhooks/
    # @see Strava::Webhooks::Models::Challenge
    # @see Strava::Webhooks::Models::Event
    #
    class Client < Strava::Web::Client
      attr_accessor(*Config::ATTRIBUTES)

      #
      # Initialize a new Webhooks client.
      #
      # @param [Hash] options Configuration options
      # @option options [String] :client_id Strava application client ID (required)
      # @option options [String] :client_secret Strava application client secret (required)
      # @option options [String] :endpoint API endpoint URL (defaults to https://www.strava.com/api/v3)
      #
      def initialize(options = {})
        Strava::Webhooks::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Webhooks.config.send(key))
        end
        super
      end

      def request(method, path, options)
        super(method, path, { client_id: client_id, client_secret: client_secret }.merge(options))
      end

      #
      # List existing push subscriptions.
      #
      # Returns all active webhook subscriptions for your application.
      # Typically, Strava only allows one subscription per application.
      #
      # @param [Hash] options Additional options
      #
      # @return [Array<Strava::Webhooks::Models::Subscription>] Array of subscriptions
      #
      # @example List subscriptions
      #   subscriptions = client.push_subscriptions
      #   subscriptions.each { |sub| puts "ID: #{sub.id}, URL: #{sub.callback_url}" }
      #
      # @see https://developers.strava.com/docs/webhooks/
      #
      def push_subscriptions(options = {})
        get('push_subscriptions', options).map do |row|
          Strava::Webhooks::Models::Subscription.new(row)
        end
      end

      #
      # Delete a push subscription.
      #
      # Removes an existing webhook subscription by ID. After deletion,
      # your application will no longer receive webhook events.
      #
      # @param [Integer, Hash] id_or_options Subscription ID or options hash with :id key
      # @param [Hash] options Additional options
      #
      # @return [nil]
      #
      # @example Delete subscription
      #   client.delete_push_subscription(12345)
      #
      # @see https://developers.strava.com/docs/webhooks/
      #
      def delete_push_subscription(id_or_options, options = {})
        id, options = parse_args(id_or_options, options)
        delete("push_subscriptions/#{id}", options)
        nil
      end

      #
      # Create a new push subscription.
      #
      # Creates a webhook subscription for receiving real-time activity updates.
      # Your callback URL must be publicly accessible and handle both GET (for validation)
      # and POST (for events) requests.
      #
      # Strava will send a GET request to validate your callback URL before creating
      # the subscription. Your endpoint must respond with the challenge token.
      #
      # @param [Hash] options Subscription parameters
      # @option options [String] :callback_url Public HTTPS URL where webhook events will be sent (required)
      # @option options [String] :verify_token Token for validating webhook challenges (required)
      #
      # @return [Strava::Webhooks::Models::Subscription] The created subscription
      #
      # @example Create subscription
      #   subscription = client.create_push_subscription(
      #     callback_url: 'https://myapp.com/strava/webhook',
      #     verify_token: 'my_secret_token_123'
      #   )
      #   puts "Subscription ID: #{subscription.id}"
      #
      # @see https://developers.strava.com/docs/webhooks/
      # @see Strava::Webhooks::Models::Challenge
      #
      def create_push_subscription(options = {})
        Strava::Webhooks::Models::Subscription.new(post('push_subscriptions', options))
      end

      class << self
        #
        # Configure the Webhooks client with a block.
        #
        # @yield [Config] Yields the configuration module for setup
        # @return [Module] The Config module
        #
        # @example
        #   Strava::Webhooks::Client.configure do |config|
        #     config.client_id = ENV['STRAVA_CLIENT_ID']
        #     config.client_secret = ENV['STRAVA_CLIENT_SECRET']
        #   end
        #
        def configure
          block_given? ? yield(Config) : Config
        end

        #
        # Returns the current Webhooks client configuration.
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

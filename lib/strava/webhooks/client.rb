# frozen_string_literal: true

module Strava
  module Webhooks
    class Client < Strava::Web::Client
      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        Strava::Webhooks::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Webhooks.config.send(key))
        end
        super
      end

      def request(method, path, options)
        super method, path, { client_id: client_id, client_secret: client_secret }.merge(options)
      end

      #
      # Get existing push subscriptions.
      #
      def push_subscriptions(options = {})
        get('push_subscriptions', options).map do |row|
          Strava::Webhooks::Models::Subscription.new(row)
        end
      end

      #
      # Delete an existing push subscription.
      #
      def delete_push_subscription(id_or_options, options = {})
        id, options = parse_args(id_or_options, options)
        delete("push_subscriptions/#{id}", options)
        nil
      end

      #
      # Create a subscription.
      #
      # @option options [String] :callback_url
      #   Address where webhook events will be sent.
      # @option options [String] :verify_token
      #   String chosen by the application owner for client security. An identical string should be returned by Strava's subscription service.
      #
      def create_push_subscription(options = {})
        Strava::Webhooks::Models::Subscription.new(post('push_subscriptions', options))
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

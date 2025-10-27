# frozen_string_literal: true

module Strava
  module Webhooks
    module Models
      #
      # Represents a webhook subscription.
      #
      # Webhook subscriptions allow your application to receive real-time notifications
      # when athletes create or update activities, or update their profile information.
      # Each subscription is associated with a callback URL where events will be posted.
      #
      # @example List subscriptions
      #   subscriptions = client.subscriptions
      #   subscriptions.each do |sub|
      #     puts "Subscription #{sub.id}: #{sub.callback_url}"
      #   end
      #
      # @see Strava::Webhooks::Client
      # @see https://developers.strava.com/docs/webhooks/
      #
      class Subscription < Strava::Models::Response
        # @return [Integer] The subscription ID
        property 'id'

        # @return [Integer] The ID of the application that created the subscription
        property 'application_id'

        # @return [String] The callback URL where webhook events will be posted
        property 'callback_url'

        # @return [Integer] Resource state indicator
        property 'resource_state'

        # @return [Time] When the subscription was created
        property 'created_at', transform_with: ->(v) { Time.parse(v) }

        # @return [Time] When the subscription was last updated
        property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      end
    end
  end
end

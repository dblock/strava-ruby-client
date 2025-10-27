# frozen_string_literal: true

module Strava
  module Webhooks
    module Models
      #
      # Represents a webhook event from Strava.
      #
      # After successfully creating a webhook subscription, Strava will send POST
      # requests to your callback URL when activity events occur. Events include
      # activity creation, updates, and deletions.
      #
      # @example Handle webhook event in Rails
      #   def webhook
      #     if request.post?
      #       event = Strava::Webhooks::Models::Event.new(JSON.parse(request.body.read))
      #
      #       case event.object_type
      #       when 'activity'
      #         case event.aspect_type
      #         when 'create'
      #           # Fetch and process the new activity
      #           activity = client.activity(event.id)
      #           process_new_activity(activity)
      #         when 'update'
      #           # Handle activity update
      #           puts "Activity #{event.id} updated: #{event.updates.inspect}"
      #         when 'delete'
      #           # Handle activity deletion
      #           delete_activity(event.id)
      #         end
      #       when 'athlete'
      #         # Handle athlete updates (authorization revoked, etc.)
      #       end
      #
      #       head :ok
      #     end
      #   end
      #
      # @see Strava::Webhooks::Client#create_push_subscription
      # @see https://developers.strava.com/docs/webhooks/
      #
      class Event < Hashie::Trash
        # @return [String] Type of object (e.g., "activity", "athlete")
        property 'object_type'

        # @return [Integer] ID of the object (activity ID, athlete ID, etc.)
        property 'id', from: 'object_id'

        # @return [String] Type of event: "create", "update", or "delete"
        property 'aspect_type'

        # @return [Hash] Map of updated properties (only for update events)
        property 'updates'

        # @return [Integer] Athlete ID who owns the object
        property 'owner_id'

        # @return [Integer] ID of the webhook subscription
        property 'subscription_id'

        # @return [Time] Timestamp when the event occurred
        property 'event_time', transform_with: ->(v) { Time.at(v) }
      end
    end
  end
end

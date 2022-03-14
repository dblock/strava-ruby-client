# frozen_string_literal: true

module Strava
  module Webhooks
    module Models
      class Event < Hashie::Trash
        property 'object_type'
        property 'object_id'
        property 'aspect_type'
        property 'updates'
        property 'owner_id'
        property 'subscription_id'
        property 'event_time', transform_with: ->(v) { Time.at(v) }
      end
    end
  end
end

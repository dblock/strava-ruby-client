module Strava
  module Webhooks
    module Models
      class Subscription < Hashie::Trash
        property 'id'
        property 'application_id'
        property 'callback_url'
        property 'resource_state'
        property 'created_at', transform_with: ->(v) { Time.parse(v) }
        property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      end
    end
  end
end

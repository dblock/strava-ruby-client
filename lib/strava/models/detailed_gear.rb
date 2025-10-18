# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-DetailedGear
    class DetailedGear < Strava::Models::Response
      property 'id'
      property 'resource_state'
      property 'primary'
      property 'name'
      include Mixins::Distance
      property 'brand_name'
      property 'model_name'
      property 'frame_type'
      property 'description'
      # undocumented
      property 'nickname'
      property 'retired'
      property 'converted_distance'
      property 'notification_distance'
      property 'weight'
    end
  end
end

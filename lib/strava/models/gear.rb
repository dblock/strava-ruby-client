module Strava
  module Models
    class Gear < Model
      include Mixins::Distance

      property 'id'
      property 'resource_state'
      property 'distance'
      property 'name'
      property 'primary'
      property 'brand_name'
      property 'model_name'
      property 'description'
      property 'frame_type'
      property 'weight'
      property 'retired'
    end
  end
end

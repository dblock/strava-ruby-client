module Strava
  module Models
    class Gear < Model
      include Mixins::MetricDistance

      property 'id'
      property 'resource_state'
      property 'distance'
      property 'name'
      property 'primary'
      property 'brand_name'
      property 'model_name'
      property 'description'
    end
  end
end

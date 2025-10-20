# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-SummaryGear
    class SummaryGear < Strava::Models::Response
      property 'id'
      property 'resource_state'
      property 'primary'
      property 'name'
      include Mixins::Distance
      # undocumented
      property 'nickname'
      property 'retired'
      property 'converted_distance'
    end
  end
end

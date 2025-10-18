# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module EstimatedMovingTime
        extend ActiveSupport::Concern
        include TimeInHours

        included do
          property 'estimated_moving_time'
        end

        def estimated_moving_time_in_hours_s
          time_in_hours_s estimated_moving_time
        end
      end
    end
  end
end

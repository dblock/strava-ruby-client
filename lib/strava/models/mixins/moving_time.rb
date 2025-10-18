# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module MovingTime
        extend ActiveSupport::Concern
        include TimeInHours

        included do
          property 'moving_time'
        end

        def moving_time_in_hours_s
          time_in_hours_s moving_time
        end
      end
    end
  end
end

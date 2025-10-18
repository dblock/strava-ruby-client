# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module ElapsedTime
        extend ActiveSupport::Concern
        include TimeInHours

        included do
          property 'elapsed_time'
        end

        def elapsed_time_in_hours_s
          time_in_hours_s elapsed_time
        end
      end
    end
  end
end

module Strava
  module Models
    module Mixins
      module Ratelimit
        extend ActiveSupport::Concern

        included do
          property 'ratelimit_limit'
          property 'ratelimit_usage'
          property 'ratelimit_fiveteen_minutes'
          property 'ratelimit_total_day'
          property 'ratelimit_fiveteen_minutes_usage'
          property 'ratelimit_total_day_usage'
          property 'ratelimit_fiveteen_minutes_remaining'
          property 'ratelimit_total_day_remaining'
        end
      end
    end
  end
end

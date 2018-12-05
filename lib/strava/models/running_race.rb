module Strava
  module Models
    class RunningRace < Model
      include Mixins::Distance

      property 'id'
      property 'resource_state'
      property 'name'
      property 'running_race_type'
      property 'distance'
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'city'
      property 'state'
      property 'country'
      property 'route_ids'
      property 'measurement_preference'
      property 'url'
      property 'website_url'
      property 'status'

      def strava_url
        "https://www.strava.com/running-races/#{url}" if url
      end

      def distance_s
        case measurement_preference
        when 'meters' then distance_in_kilometers_s
        when 'feet' then distance_in_miles_s
        end
      end
    end
  end
end

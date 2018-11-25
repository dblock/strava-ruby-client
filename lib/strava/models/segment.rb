module Strava
  module Models
    class Segment < Model
      include Mixins::Distance

      property 'id'
      property 'resource_state'
      property 'name'
      property 'maximum_grade'
      property 'elevation_high'
      property 'elevation_low'
      property 'activity_type'
      property 'average_grade'
      property 'climb_category'
      property 'city'
      property 'state'
      property 'country'
      property 'start_latlng'
      property 'end_latlng'
      property 'start_latitude'
      property 'start_longitude'
      property 'end_latitude'
      property 'end_longitude'
      property 'private'
      property 'hazardous'
      property 'starred'

      def units
        :metric
      end
    end
  end
end

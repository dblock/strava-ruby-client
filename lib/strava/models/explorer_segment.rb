module Strava
  module Models
    class ExplorerSegment < Model
      include Mixins::MetricDistance

      property 'id'
      property 'resource_state'
      property 'name'
      property 'climb_category'
      property 'climb_category_desc'
      property 'avg_grade'
      property 'start_latlng'
      property 'end_latlng'
      property 'elev_difference'
      property 'points'
      property 'starred'
    end
  end
end

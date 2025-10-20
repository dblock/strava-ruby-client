# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-ExplorerSegment
    class ExplorerSegment < Strava::Models::Response
      property 'id'
      property 'name'
      property 'climb_category'
      property 'climb_category_desc'
      property 'avg_grade'
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }
      property 'end_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }
      property 'elev_difference'
      include Mixins::Distance
      property 'points'
      # undocumented
      property 'resource_state'
      property 'starred'
      property 'elevation_profile'
      property 'local_legend_enabled'
    end
  end
end

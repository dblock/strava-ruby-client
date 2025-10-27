# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a segment found via segment exploration.
    #
    # Used when searching for segments in a geographic area. Contains basic segment
    # information including location, elevation, and difficulty category.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-ExplorerSegment Strava API ExplorerSegment reference
    # @see Strava::Api::Client#explore_segments
    # @see Strava::Models::SummarySegment
    #
    # @example Exploring segments near a location
    #   segments = client.explore_segments(
    #     bounds: [37.7, -122.5, 37.8, -122.4],  # [sw_lat, sw_lng, ne_lat, ne_lng]
    #     activity_type: 'running'
    #   )
    #
    #   segments.each do |segment|
    #     puts "#{segment.name} (#{segment.distance_s})"
    #     puts "  Climb: #{segment.climb_category_desc}"
    #     puts "  Grade: #{segment.avg_grade}%"
    #     puts "  Elevation: #{segment.elev_difference}m"
    #     puts "  Starred: #{segment.starred}"
    #   end
    #
    class ExplorerSegment < Strava::Models::Response
      # @return [Integer] Unique identifier for this segment
      property 'id'

      # @return [String] Name of the segment
      property 'name'

      # @return [Integer] Climb category (0=uncategorized, 5=easiest, 1=hardest, HC=hors catégorie)
      property 'climb_category'

      # @return [String] Human-readable description of climb category (e.g., "NC", "4", "3", "2", "1", "HC")
      property 'climb_category_desc'

      # @return [Float] Average grade/incline as a percentage
      property 'avg_grade'

      # @return [LatLng] GPS coordinates of segment start point
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [LatLng] GPS coordinates of segment end point
      property 'end_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [Float] Net elevation difference in meters (positive for climbs, negative for descents)
      property 'elev_difference'

      # Includes distance in meters and conversion helper methods
      include Mixins::Distance

      # @return [String, nil] Encoded polyline of the segment path
      property 'points'

      # @return [Integer] Resource state indicator
      # @note Not documented by Strava API
      property 'resource_state'

      # @return [Boolean, nil] Whether the current athlete has starred this segment
      # @note Not documented by Strava API
      property 'starred'

      # @return [String, nil] URL or path to elevation profile visualization
      # @note Not documented by Strava API
      property 'elevation_profile'

      # @return [Boolean, nil] Whether local legend feature is enabled for this segment
      # @note Not documented by Strava API
      property 'local_legend_enabled'
    end
  end
end

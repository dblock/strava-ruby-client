# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents summary information about a segment.
    #
    # A segment is a specific section of road or trail that athletes can compete on.
    # This summary version contains key information about the segment including
    # location, elevation, and the athlete's personal stats on it.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-SummarySegment Strava API SummarySegment reference
    # @see Strava::Models::DetailedSegment
    # @see Strava::Models::ExplorerSegment
    # @see Strava::Models::SummaryPRSegmentEffort
    #
    # @example Accessing segment information from an effort
    #   activity = client.activity(1234567890)
    #   activity.segment_efforts.each do |effort|
    #     segment = effort.segment
    #     puts "#{segment.name} (#{segment.distance_s})"
    #     puts "  Location: #{segment.city}, #{segment.state}, #{segment.country}"
    #     puts "  Grade: #{segment.average_grade}% (max: #{segment.maximum_grade}%)"
    #     puts "  Elevation: #{segment.elevation_low}m - #{segment.elevation_high}m"
    #
    #     if segment.athlete_pr_effort
    #       puts "  Your PR: #{segment.athlete_pr_effort.pr_elapsed_time}s"
    #     end
    #   end
    #
    class SummarySegment < Strava::Models::Response
      # @return [Integer] Unique identifier for this segment
      property 'id'

      # @return [String] Name of the segment
      property 'name'

      # @return [String] Activity type this segment is for ("Ride" or "Run")
      property 'activity_type'

      # Includes distance in meters and conversion helper methods
      include Mixins::Distance

      # @return [Float] Average grade/incline as a percentage
      property 'average_grade'

      # @return [Float] Maximum grade/incline as a percentage
      property 'maximum_grade'

      # @return [Float] Highest elevation point on the segment in meters
      property 'elevation_high'

      # @return [Float] Lowest elevation point on the segment in meters
      property 'elevation_low'

      # @return [LatLng] GPS coordinates of segment start point
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [LatLng] GPS coordinates of segment end point
      property 'end_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [Integer] Climb category (0=uncategorized, 5=easiest, 1=hardest, HC=hors catégorie)
      property 'climb_category'

      # @return [String, nil] City where the segment is located
      property 'city'

      # @return [String, nil] State/province where the segment is located
      property 'state'

      # @return [String, nil] Country where the segment is located
      property 'country'

      # @return [Boolean] Whether this is a private segment
      property 'private'

      # @return [SummaryPRSegmentEffort, nil] Athlete's personal record on this segment
      property 'athlete_pr_effort', transform_with: ->(v) { Strava::Models::SummaryPRSegmentEffort.new(v) }

      # @return [SummarySegmentEffort, nil] Athlete's statistics for this segment
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SummarySegmentEffort.new(v) }

      # @return [Integer] Resource state indicator
      # @note Not documented by Strava API
      property 'resource_state'

      # @return [String, nil] URL or path to elevation profile visualization
      # @note Not documented by Strava API
      property 'elevation_profile'

      # @return [Array, nil] Array of elevation profile data
      # @note Not documented by Strava API
      property 'elevation_profiles'

      # @return [Boolean, nil] Whether this segment has been flagged as hazardous
      # @note Not documented by Strava API
      property 'hazardous'

      # @return [Boolean, nil] Whether the current athlete has starred this segment
      # @note Not documented by Strava API
      property 'starred'

      # @return [Time, nil] Date when the athlete starred this segment
      # @note Not documented by Strava API
      property 'starred_date', transform_with: ->(v) { Time.parse(v) }

      # @return [Integer, nil] Athlete's PR time on this segment in seconds
      # @note Not documented by Strava API
      property 'pr_time'
    end
  end
end

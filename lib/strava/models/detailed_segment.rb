# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents detailed information about a Strava segment.
    #
    # Segments are specific sections of road or trail where athletes can compete
    # for best times. This model contains comprehensive segment information including
    # location, elevation profile, statistics, and the athlete's personal records.
    #
    # Includes helper mixins for formatting distance and elevation.
    #
    # @example Get segment details
    #   segment = client.segment(229781)
    #   puts segment.name
    #   puts "#{segment.distance_s} with #{segment.average_grade}% average grade"
    #   puts "Location: #{segment.city}, #{segment.state}"
    #   puts "#{segment.athlete_count} athletes have ridden this segment"
    #
    #   if segment.athlete_segment_stats
    #     pr = segment.athlete_segment_stats
    #     puts "Your PR: #{pr.elapsed_time_in_hours_s}"
    #   end
    #
    # @see SummarySegment
    # @see https://developers.strava.com/docs/reference/#api-models-DetailedSegment
    #
    class DetailedSegment < Strava::Models::Response
      # @return [Integer] Segment ID
      property 'id'

      # @return [String] Segment name
      property 'name'

      # @return [String] Activity type ('Ride' or 'Run')
      property 'activity_type'

      include Mixins::Distance

      # @return [Float] Average grade as a percentage
      property 'average_grade'

      # @return [Float] Maximum grade as a percentage
      property 'maximum_grade'

      # @return [Float] Highest elevation point in meters
      property 'elevation_high'

      # @return [Float] Lowest elevation point in meters
      property 'elevation_low'

      # @return [LatLng] Starting coordinates [latitude, longitude]
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [LatLng] Ending coordinates [latitude, longitude]
      property 'end_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      # @return [Integer] Climb category (0 = uncategorized, 1-5 = category climbs, HC = hors catégorie)
      property 'climb_category'

      # @return [String, nil] City where the segment is located
      property 'city'

      # @return [String, nil] State/province where the segment is located
      property 'state'

      # @return [String, nil] Country where the segment is located
      property 'country'

      # @return [Boolean] Whether this segment is private
      property 'private'

      # @return [SummaryPRSegmentEffort, nil] The authenticated athlete's PR on this segment
      property 'athlete_pr_effort', transform_with: ->(v) { Strava::Models::SummaryPRSegmentEffort.new(v) }

      # @return [SummarySegmentEffort, nil] The authenticated athlete's statistics on this segment
      property 'athlete_segment_stats', transform_with: ->(v) { Strava::Models::SummarySegmentEffort.new(v) }

      # @return [Time] When the segment was created
      property 'created_at', transform_with: ->(v) { Time.parse(v) }

      # @return [Time] When the segment was last updated
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }

      include Mixins::TotalElevationGain

      # @return [Map] Segment map with polyline data
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }

      # @return [Integer] Total number of efforts on this segment
      property 'effort_count'

      # @return [Integer] Total number of unique athletes who have attempted this segment
      property 'athlete_count'

      # @return [Boolean] Whether this segment has been flagged as hazardous
      property 'hazardous'

      # @return [Integer] Number of athletes who have starred this segment
      property 'star_count'

      # @note Undocumented in official API
      # @return [Integer, nil] Resource state indicator
      property 'resource_state'

      # @note Undocumented in official API
      # @return [String, nil] Elevation profile data (deprecated, use elevation_profiles)
      property 'elevation_profile'

      # @note Undocumented in official API
      # @return [Array, nil] Collection of elevation profile data points
      property 'elevation_profiles'

      # @note Undocumented in official API
      # @return [Boolean, nil] Whether the authenticated athlete has starred this segment
      property 'starred'

      # @note Undocumented in official API
      # @return [Xoms, nil] QOM/KOM information for this segment
      property 'xoms', transform_with: ->(v) { Strava::Models::Xoms.new(v) }

      # @note Undocumented in official API
      # @return [LocalLegend, nil] Current Local Legend holder for this segment
      property 'local_legend', transform_with: ->(v) { Strava::Models::LocalLegend.new(v) }
    end
  end
end

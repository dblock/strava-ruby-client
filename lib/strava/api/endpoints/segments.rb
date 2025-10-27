# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava segments.
      #
      # Segments are specific sections of road or trail where athletes can compete for time.
      # This module provides methods for exploring, retrieving, and starring segments.
      #
      # @see https://developers.strava.com/docs/reference/#api-Segments
      #
      module Segments
        #
        # Explore segments in a geographic area.
        #
        # Returns the top 10 segments matching a specified query within a rectangular
        # geographic boundary. Useful for discovering popular segments in an area.
        #
        # @param [Hash] options Search parameters
        # @option options [Array<Float>] :bounds Required. Rectangular boundary as [sw_lat, sw_lng, ne_lat, ne_lng]
        # @option options [String] :activity_type Activity type: 'running' or 'riding'
        # @option options [Integer] :min_cat Minimum climbing category (0-5)
        # @option options [Integer] :max_cat Maximum climbing category (0-5)
        #
        # @return [Array<Strava::Models::ExplorerSegment>] Array of segments
        #
        # @example Explore segments in an area
        #   segments = client.explore_segments(
        #     bounds: [40.7,-74.0,40.8,-73.9],
        #     activity_type: 'running'
        #   )
        #
        # @see https://developers.strava.com/docs/reference/#api-Segments-exploreSegments
        #
        def explore_segments(options = {})
          throw ArgumentError.new('Required argument :bounds missing') if options[:bounds].nil?
          bounds = options[:bounds]
          bounds = bounds.map(&:to_s).join(',') if bounds.is_a?(Array)
          get('segments/explore', options.merge(bounds: bounds))['segments'].map do |row|
            Strava::Models::ExplorerSegment.new(row)
          end
        end

        #
        # List of the authenticated athlete's starred segments.
        #
        # Returns a paginated list of segments that the authenticated athlete has starred.
        # Starred segments are favorites that the athlete wants to track their performance on.
        #
        # @param options [Hash] Pagination options
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        # @yield [SummarySegment] Yields each segment in the paginated results
        # @return [Array<SummarySegment>, Cursor] Array of starred segments or Cursor for iteration
        #
        # @example List all starred segments
        #   starred = client.starred_segments
        #   starred.each do |segment|
        #     puts "#{segment.name}: #{segment.distance_s}"
        #   end
        #
        def starred_segments(options = {}, &block)
          paginate 'segments/starred', options, Strava::Models::SummarySegment, &block
        end

        #
        # Returns the specified segment.
        #
        # Retrieves detailed information about a specific segment including location,
        # elevation profile, and the athlete's personal records on that segment.
        #
        # @param id_or_options [String, Integer, Hash] Either a segment ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        # @return [DetailedSegment] The detailed segment information
        #
        # @example Get a segment by ID
        #   segment = client.segment(229781)
        #   puts "#{segment.name}: #{segment.distance_s} with #{segment.average_grade}% grade"
        #
        def segment(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::DetailedSegment.new(get("segments/#{id}", options))
        end

        #
        # Stars/Unstars the given segment for the authenticated athlete.
        #
        # Adds or removes a segment from the athlete's starred/favorite segments.
        # Starred segments appear in the athlete's starred segments list and can
        # be used to track performance over time.
        #
        # @param id_or_options [String, Integer, Hash] Either a segment ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Boolean] :starred If true, star the segment; if false, unstar the segment (required)
        #
        # @return [DetailedSegment] The updated segment with new starred status
        #
        # @raise [ArgumentError] If :starred option is not provided
        #
        # @example Star a segment
        #   segment = client.star_segment(229781, starred: true)
        #
        # @example Unstar a segment
        #   segment = client.star_segment(229781, starred: false)
        #
        def star_segment(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          throw ArgumentError.new('Required argument :starred missing') if options[:starred].nil?
          Strava::Models::DetailedSegment.new(put("segments/#{id}/starred", options))
        end
      end
    end
  end
end

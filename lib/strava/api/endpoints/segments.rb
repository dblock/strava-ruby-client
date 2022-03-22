# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      module Segments
        #
        # Returns the top 10 segments matching a specified query.
        #
        # @option options [Array[Float]] :bounds
        #   The latitude and longitude for two points describing a rectangular boundary for the search: [southwest corner latitude, southwest corner longitude, northeast corner latitude, northeast corner longitude].
        # @option options [String] :activity_type
        #   Desired activity type. May take one of the following values: running, riding.
        # @option options [Integer] :min_cat
        #   The minimum climbing category.
        # @option options [Integer] :max_cat
        #   The maximum climbing category.
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
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def starred_segments(options = {}, &block)
          paginate 'segments/starred', options, Strava::Models::Segment, &block
        end

        #
        # Returns the specified segment.
        #
        # @option options [String] :id
        #   The identifier of the segment.
        #
        def segment(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Segment.new(get("segments/#{id}", options))
        end

        #
        # Stars/Unstars the given segment for the authenticated athlete.
        #
        # @option options [String] :id
        #   The identifier of the segment to star.
        # @option options [Boolean] :starred
        #   If true, star the segment; if false, unstar the segment.
        #
        def star_segment(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          throw ArgumentError.new('Required argument :starred missing') if options[:starred].nil?
          Strava::Models::Segment.new(put("segments/#{id}/starred", options))
        end
      end
    end
  end
end

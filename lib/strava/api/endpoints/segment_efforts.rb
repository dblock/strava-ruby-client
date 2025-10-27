# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava segment efforts.
      #
      # Segment efforts represent an athlete's attempt on a specific segment during an
      # activity. Each time an activity passes through a segment, a segment effort is
      # created with details like elapsed time, distance, and ranking information.
      #
      # @see https://developers.strava.com/docs/reference/#api-SegmentEfforts
      #
      module SegmentEfforts
        #
        # Returns a segment effort from an activity that is owned by the authenticated athlete.
        #
        # @param id_or_options [String, Integer, Hash] Either a segment effort ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        def segment_effort(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::DetailedSegmentEffort.new(get("segment_efforts/#{id}", options))
        end

        #
        # Returns a set of the authenticated athlete's segment efforts for a given segment.
        #
        # @param id_or_options [String, Integer, Hash] Either a segment ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Integer] :page Page number
        # @option options [Integer] :per_page Number of items per page. Defaults to 30
        #
        def segment_efforts(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "segments/#{id}/all_efforts", options, Strava::Models::DetailedSegmentEffort, &block
        end
      end
    end
  end
end

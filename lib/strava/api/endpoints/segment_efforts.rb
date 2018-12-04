module Strava
  module Api
    module Endpoints
      module SegmentEfforts
        #
        # Returns a segment effort from an activity that is owned by the authenticated athlete.
        #
        # @option options [String] :id
        #   The identifier of the segment effort.
        #
        def segment_effort(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::SegmentEffort.new(get("segment_efforts/#{id}", options))
        end

        #
        # Returns a set of the authenticated athlete's segment efforts for a given segment.
        #
        # @option options [Integer] :id
        #   The identifier of the segment.
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def segment_efforts(id_or_options, options = {}, &block)
          id, options = parse_args(id_or_options, options)
          paginate "segments/#{id}/all_efforts", options, Strava::Models::SegmentEffort, &block
        end
      end
    end
  end
end

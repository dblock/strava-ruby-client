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
        def segment_effort(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::SegmentEffort.new(get("segment_efforts/#{options[:id]}", options.except(:id)))
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
        def segment_efforts(options = {}, &block)
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          paginate "segments/#{options[:id]}/all_efforts", options.except(:id), Strava::Models::SegmentEffort, &block
        end
      end
    end
  end
end

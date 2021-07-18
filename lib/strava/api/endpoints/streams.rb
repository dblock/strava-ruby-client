module Strava
  module Api
    module Endpoints
      module Streams
        #
        # Returns the given activity's streams.
        #
        # @option options [String] :id
        #   The identifier of the activity.
        # @option options [Array[String]] :keys
        #   Desired stream types.
        # @option options [Boolean] :key_by_type
        #   Must be true.
        #
        def activity_streams(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          query = options.dup
          query[:key_by_type] = true unless options.key?(:key_by_type)
          query[:keys] = options[:keys].join(',') if options[:keys] && options[:keys].is_a?(Array)
          extract_entity(get("activities/#{id}/streams", query), Strava::Models::StreamSet)
        end

        #
        # Returns a set of streams for a segment effort completed by the authenticated athlete.
        #
        # @option options [String] :id
        #   The identifier of the segment effort.
        # @option options [Array[String]] :keys
        #   The types of streams to return.
        # @option options [Boolean] :key_by_type
        #   Must be true.
        #
        def segment_effort_streams(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          query = options.dup
          query[:key_by_type] = true unless options.key?(:key_by_type)
          query[:keys] = options[:keys].join(',') if options[:keys] && options[:keys].is_a?(Array)
          extract_entity(get("segment_efforts/#{id}/streams", query), Strava::Models::StreamSet)
        end

        #
        # Returns the given segment's streams.
        #
        # @option options [String] :id
        #   The identifier of the segment.
        # @option options [Array[String]] :keys
        #   The types of streams to return.
        # @option options [Boolean] :key_by_type
        #   Must be true.
        #
        def segment_streams(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          query = options.dup
          query[:key_by_type] = true unless options.key?(:key_by_type)
          query[:keys] = options[:keys].join(',') if options[:keys] && options[:keys].is_a?(Array)
          extract_entity(get("segments/#{id}/streams", query), Strava::Models::StreamSet)
        end
      end
    end
  end
end

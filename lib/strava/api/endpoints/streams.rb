# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava streams.
      #
      # Streams represent the raw data of uploaded activities. They can be thought of
      # as a collection of time series data, where each data point is sampled at a
      # specific time or distance. Available stream types include altitude, cadence,
      # distance, heartrate, latlng, moving, power, temp, time, and velocity.
      #
      # @see https://developers.strava.com/docs/reference/#api-Streams
      #
      module Streams
        #
        # Returns the given activity's streams.
        #
        # @param id_or_options [String, Integer, Hash] Either an activity ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Array<String>] :keys Desired stream types (e.g., ['time', 'latlng', 'distance', 'altitude'])
        # @option options [Boolean] :key_by_type Must be true
        #
        def activity_streams(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          query = options.dup
          query[:key_by_type] = true unless options.key?(:key_by_type)
          query[:keys] = options[:keys].join(',') if options[:keys].is_a?(Array)
          Strava::Models::StreamSet.new(get("activities/#{id}/streams", query))
        end

        #
        # Returns a set of streams for a segment effort completed by the authenticated athlete.
        #
        # @param id_or_options [String, Integer, Hash] Either a segment effort ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Array<String>] :keys The types of streams to return
        # @option options [Boolean] :key_by_type Must be true
        #
        def segment_effort_streams(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          query = options.dup
          query[:key_by_type] = true unless options.key?(:key_by_type)
          query[:keys] = options[:keys].join(',') if options[:keys].is_a?(Array)
          Strava::Models::StreamSet.new(get("segment_efforts/#{id}/streams", query))
        end

        #
        # Returns the given segment's streams.
        #
        # @param id_or_options [String, Integer, Hash] Either a segment ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        # @option options [Array<String>] :keys The types of streams to return
        # @option options [Boolean] :key_by_type Must be true
        #
        def segment_streams(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          query = options.dup
          query[:key_by_type] = true unless options.key?(:key_by_type)
          query[:keys] = options[:keys].join(',') if options[:keys].is_a?(Array)
          Strava::Models::StreamSet.new(get("segments/#{id}/streams", query))
        end
      end
    end
  end
end

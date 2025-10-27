# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents base stream metadata from the Strava API.
    #
    # Streams are time-series data for activities such as GPS coordinates, heart rate,
    # power, cadence, etc. The BaseStream provides metadata about how the stream data
    # was sampled and processed.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-BaseStream Strava API BaseStream reference
    # @see Strava::Models::Stream
    # @see Strava::Models::StreamSet
    #
    # @example Accessing stream metadata
    #   streams = client.activity_streams(1234567890, keys: 'heartrate,watts')
    #   puts streams.heartrate.original_size  # => 3600
    #   puts streams.heartrate.resolution     # => "high"
    #   puts streams.heartrate.series_type    # => "distance"
    #
    class BaseStream < Strava::Models::Response
      # @return [Integer] Total number of data points in the original stream before any resampling
      property 'original_size'

      # @return [String] Resolution of the stream data ("low", "medium", or "high")
      property 'resolution'

      # @return [String] Type of series - how data points are indexed ("time" or "distance")
      property 'series_type'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a single stream of time-series data from the Strava API.
    #
    # A Stream contains both metadata about the data collection and the actual data array.
    # Common stream types include: time, distance, latlng, altitude, velocity_smooth,
    # heartrate, cadence, watts, temp, moving, and grade_smooth.
    #
    # @see https://developers.strava.com/docs/reference/#api-Streams Strava API Streams reference
    # @see Strava::Models::BaseStream
    # @see Strava::Models::StreamSet
    #
    # @example Accessing heartrate stream data
    #   streams = client.activity_streams(1234567890, keys: 'heartrate,watts')
    #   hr_data = streams.heartrate.data
    #   puts "Average HR: #{hr_data.sum / hr_data.size}"
    #   puts "Max HR: #{hr_data.max}"
    #
    # @example Working with GPS coordinates
    #   streams = client.activity_streams(1234567890, keys: 'latlng')
    #   coords = streams.latlng.data  # Array of [lat, lng] pairs
    #   coords.each do |lat, lng|
    #     puts "#{lat}, #{lng}"
    #   end
    #
    class Stream < Strava::Models::Response
      # @return [Integer] Total number of data points in the original stream before any resampling
      property 'original_size'

      # @return [String] Resolution of the stream data ("low", "medium", or "high")
      property 'resolution'

      # @return [String] Type of series - how data points are indexed ("time" or "distance")
      property 'series_type'

      # @return [Array] Array of data points. The type of data depends on the stream:
      #   - time: Array of integers (seconds from start)
      #   - distance: Array of floats (meters from start)
      #   - latlng: Array of [latitude, longitude] coordinate pairs
      #   - altitude: Array of floats (meters)
      #   - velocity_smooth: Array of floats (meters per second)
      #   - heartrate: Array of integers (beats per minute)
      #   - cadence: Array of integers (RPM for cycling, steps/min for running)
      #   - watts: Array of integers (power in watts)
      #   - temp: Array of integers (temperature in celsius)
      #   - moving: Array of booleans (true if moving, false if stopped)
      #   - grade_smooth: Array of floats (grade as percentage)
      property 'data'
    end
  end
end

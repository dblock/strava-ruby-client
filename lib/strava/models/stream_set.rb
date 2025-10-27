# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a collection of activity streams from the Strava API.
    #
    # A StreamSet is returned when requesting activity or segment effort streams
    # and contains multiple synchronized time-series data streams. Each stream
    # contains data points that correspond to the same moments in time or distance.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-StreamSet Strava API StreamSet reference
    # @see Strava::Models::Stream
    # @see Strava::Api::Client#activity_streams
    # @see Strava::Api::Client#segment_effort_streams
    #
    # @example Fetching and analyzing multiple streams
    #   streams = client.activity_streams(1234567890,
    #     keys: 'time,distance,heartrate,watts',
    #     key_by_type: true
    #   )
    #
    #   # Access individual streams
    #   time_data = streams.time.data           # Array of elapsed seconds
    #   hr_data = streams.heartrate.data        # Array of heart rate values
    #   power_data = streams.watts.data         # Array of power values
    #
    #   # Calculate average power for time above threshold HR
    #   threshold_hr = 160
    #   time_data.each_with_index do |time, i|
    #     if hr_data[i] > threshold_hr
    #       puts "At #{time}s: HR=#{hr_data[i]}, Power=#{power_data[i]}W"
    #     end
    #   end
    #
    class StreamSet < Strava::Models::Response
      # @return [Stream, nil] Time stream - elapsed seconds from activity start
      property 'time', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Distance stream - meters from activity start
      property 'distance', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] GPS coordinate stream - array of [latitude, longitude] pairs
      property 'latlng', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Altitude stream - elevation in meters
      property 'altitude', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Smoothed velocity stream - speed in meters per second
      property 'velocity_smooth', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Heart rate stream - beats per minute
      property 'heartrate', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Cadence stream - RPM for cycling, steps per minute for running
      property 'cadence', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Power stream - watts
      property 'watts', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Temperature stream - degrees celsius
      property 'temp', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Moving stream - boolean indicating whether athlete is moving
      property 'moving', transform_with: ->(v) { Strava::Models::Stream.new(v) }

      # @return [Stream, nil] Smoothed grade stream - grade as percentage
      property 'grade_smooth', transform_with: ->(v) { Strava::Models::Stream.new(v) }
    end
  end
end

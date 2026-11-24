# frozen_string_literal: true

module Strava
  #
  # Base model class for all Strava models.
  #
  # This class extends Hashie::Trash to provide a flexible data structure
  # for Strava API responses. All model classes in the library inherit from this.
  #
  # Features:
  # * Ignores undeclared properties from API responses
  # * Provides hash-like access to properties
  # * Supports property transformations
  #
  # @see Strava::Models::Response
  # @see https://github.com/hashie/hashie
  #
  class Model < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared

    #
    # Parses a timestamp from the Strava API.
    #
    # Strava returns ISO 8601 timestamps, which Time.iso8601 parses much faster
    # than Time.parse. Other formats fall back to Time.parse.
    #
    # @param value [String] timestamp, e.g. "2018-02-20T18:02:13Z"
    # @return [Time]
    #
    def self.parse_time(value)
      Time.iso8601(value)
    rescue ArgumentError
      Time.parse(value)
    end
  end
end

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
  end
end

# frozen_string_literal: true

module Strava
  #
  # Mixin module for deep copying objects.
  #
  # This module provides a helper method for creating deep copies of objects
  # using Ruby's Marshal serialization. Unlike shallow cloning (which only
  # duplicates the top-level object), deep copying recursively duplicates all
  # nested objects and collections.
  #
  # This is particularly useful when working with model objects that contain
  # nested hashes or arrays, ensuring modifications to the copy don't affect
  # the original object.
  #
  # @example Deep copying a nested hash
  #   include Strava::DeepCopyable
  #   original = {a: {b: [1, 2, 3]}}
  #   copy = deep_copy(original)
  #   copy[:a][:b] << 4
  #   original[:a][:b]  # => [1, 2, 3] (unchanged)
  #
  module DeepCopyable
    #
    # Ruby's way of creating a true deep copy/clone.
    #
    # @param [Object] obj of any kind
    #
    # @return [Object] deep clone of what was passed into
    #
    def deep_copy(obj)
      Marshal.load(Marshal.dump(obj))
    end
  end
end

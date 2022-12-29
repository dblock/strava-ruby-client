# frozen_string_literal: true

module Strava
  module DeepCopyable
    #
    # Ruby's way of creating a true deep copy/clone
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

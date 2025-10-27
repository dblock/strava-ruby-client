# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents minimal club information (meta level).
    #
    # Meta models contain only essential identifying information.
    # Used in contexts where only basic club reference is needed.
    #
    # @see SummaryClub
    # @see DetailedClub
    # @see https://developers.strava.com/docs/reference/#api-models-MetaClub
    #
    class MetaClub < Strava::Models::Response
      # @return [Integer] Club identifier
      property 'id'

      # @return [Integer] Resource state indicator (1=meta)
      property 'resource_state'

      # @return [String] Club name
      property 'name'
    end
  end
end

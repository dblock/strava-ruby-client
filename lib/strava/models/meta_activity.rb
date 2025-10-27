# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents minimal activity information (meta level).
    #
    # Meta models contain only essential identifying information.
    # Used in contexts where only basic activity reference is needed.
    #
    # @see SummaryActivity
    # @see DetailedActivity
    # @see https://developers.strava.com/docs/reference/#api-models-MetaActivity
    #
    class MetaActivity < Strava::Models::Response
      # @return [Integer] Activity identifier
      property 'id'

      # @return [Integer] Resource state indicator (1=meta)
      property 'resource_state'

      # @return [String] Activity visibility (e.g., "everyone", "followers_only", "only_me")
      property 'visibility'
    end
  end
end

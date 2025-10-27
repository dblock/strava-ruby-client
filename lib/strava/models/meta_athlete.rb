# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents minimal athlete information (meta level).
    #
    # Meta models contain only essential identifying information without
    # detailed data. Used in contexts where only basic athlete reference is needed.
    #
    # @see SummaryAthlete
    # @see DetailedAthlete
    # @see https://developers.strava.com/docs/reference/#api-models-MetaAthlete
    #
    class MetaAthlete < Strava::Models::Response
      # @return [Integer, nil] Athlete identifier (may be nil for privacy)
      property 'id'

      # @return [Integer] Resource state indicator (1=meta)
      property 'resource_state'

      # @return [String, nil] Athlete's first name
      property 'firstname'

      # @return [String, nil] Athlete's last name
      property 'lastname'
    end
  end
end

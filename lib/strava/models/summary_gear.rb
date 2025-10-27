# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents summary information about athlete's equipment/gear.
    #
    # Contains basic gear information without detailed specifications.
    # Typically returned as part of athlete profile or activity data.
    #
    # Includes the Distance mixin for formatting accumulated distance.
    #
    # @example Access gear from athlete profile
    #   athlete = client.athlete
    #   athlete.bikes.each do |bike|
    #     puts "#{bike.name}: #{bike.distance_s}"
    #   end
    #
    # @see DetailedGear
    # @see https://developers.strava.com/docs/reference/#api-models-SummaryGear
    #
    class SummaryGear < Strava::Models::Response
      # @return [String] Gear identifier (e.g., "b12345" for bike, "g12345" for shoes)
      property 'id'

      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [Boolean] Whether this is the athlete's primary gear for this type
      property 'primary'

      # @return [String] Gear name/title
      property 'name'

      include Mixins::Distance

      # @return [String] Nickname for the gear
      property 'nickname'

      # @return [Boolean] Whether gear has been retired/is no longer in use
      property 'retired'

      # @return [Float] Distance in meters after conversion (likely for imperial users)
      property 'converted_distance'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents detailed information about an athlete's equipment/gear.
    #
    # Gear includes bikes, shoes, and other equipment that athletes track mileage on.
    # Each piece of gear has a name, brand, model, and accumulated distance.
    #
    # Includes the Distance mixin for formatting accumulated distance.
    #
    # @example Get gear details
    #   gear = client.gear('b12345')
    #   puts gear.name
    #   puts "#{gear.brand_name} #{gear.model_name}"
    #   puts "Total distance: #{gear.distance_s}"
    #   puts "Weight: #{gear.weight}g" if gear.weight
    #   puts "Retired" if gear.retired
    #
    # @see SummaryGear
    # @see https://developers.strava.com/docs/reference/#api-models-DetailedGear
    #
    class DetailedGear < Strava::Models::Response
      # @return [String] Gear identifier (e.g., "b12345" for bike, "g12345" for shoes)
      property 'id'

      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [Boolean] Whether this is the athlete's primary gear for this type
      property 'primary'

      # @return [String] Gear name/title
      property 'name'

      include Mixins::Distance

      # @return [String] Brand/manufacturer name
      property 'brand_name'

      # @return [String] Model name
      property 'model_name'

      # @return [Integer] Frame type identifier (for bikes)
      property 'frame_type'

      # @return [String] Gear description/notes
      property 'description'

      # @return [String] Nickname for the gear
      property 'nickname'

      # @return [Boolean] Whether gear has been retired/is no longer in use
      property 'retired'

      # @return [Float] Distance in meters after conversion (likely for imperial users)
      property 'converted_distance'

      # @return [Float] Distance threshold for maintenance notifications (in meters)
      property 'notification_distance'

      # @return [Float] Weight of the gear in grams
      property 'weight'
    end
  end
end

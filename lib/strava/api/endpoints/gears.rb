# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava gears.
      #
      # Gears (also known as equipment) represent bikes and shoes used by athletes in
      # their activities. Gears track usage statistics like total distance and can be
      # associated with specific activities.
      #
      # @see https://developers.strava.com/docs/reference/#api-Gears
      #
      module Gears
        #
        # Returns an equipment using its identifier.
        #
        # @param id_or_options [String, Integer, Hash] Either a gear ID or a hash of options including :id
        # @param options [Hash] Additional options (if first parameter is an ID)
        #
        def gear(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::DetailedGear.new(get("gear/#{id}", options))
        end
      end
    end
  end
end

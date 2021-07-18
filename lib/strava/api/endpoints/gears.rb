module Strava
  module Api
    module Endpoints
      module Gears
        #
        # Returns an equipment using its identifier.
        #
        # @option options [String] :id
        #   Gear id.
        #
        def gear(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          extract_entity(get("gear/#{id}", options), Strava::Models::Gear)
        end
      end
    end
  end
end

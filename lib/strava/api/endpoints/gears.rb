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
          Strava::Models::Gear.new(get("gear/#{id}", options))
        end
      end
    end
  end
end

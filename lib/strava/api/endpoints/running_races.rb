# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      module RunningRaces
        #
        # Returns a running race for a given identifier.
        #
        # @option options [String] :id
        #   The identifier of the running race.
        #
        def running_race(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::RunningRace.new(get("running_races/#{id}", options))
        end
      end
    end
  end
end

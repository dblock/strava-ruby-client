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

        #
        # Returns a list running races based on a set of search criteria.
        #
        # @option options [Integer] :year
        #   Filters the list by a given year.
        #
        def running_races(options = {})
          get('running_races', options).map do |row|
            Strava::Models::RunningRace.new(row)
          end
        end
      end
    end
  end
end

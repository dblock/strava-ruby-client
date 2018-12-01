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
        def running_race(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::RunningRace.new(get("running_races/#{options[:id]}", options.except(:id)))
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

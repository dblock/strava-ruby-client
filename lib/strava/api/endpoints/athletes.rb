module Strava
  module Api
    module Endpoints
      module Athletes
        #
        # Returns the currently authenticated athlete.
        #
        def athlete
          Strava::Models::Athlete.new(get('athlete'))
        end

        #
        # Returns the the authenticated athlete's heart rate and power zones.
        #
        def athlete_zones(options = {})
          Strava::Models::Zones.new(get('athlete/zones', options))
        end

        #
        # Returns the activity stats of an athlete.
        #
        # @option options [String] :id
        #   Athlete id.
        #
        def athlete_stats(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::ActivityStats.new(get("athletes/#{id}/stats", options))
        end

        #
        # Update the currently authenticated athlete.
        #
        # @option options [Float] :weight
        #   The weight of the athlete in kilograms.
        #
        def update_athlete(options = {})
          Strava::Models::Athlete.new(put('athlete', options))
        end
      end
    end
  end
end

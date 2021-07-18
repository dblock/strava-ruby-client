module Strava
  module Api
    module Endpoints
      module Athletes
        #
        # Returns the currently authenticated athlete.
        #
        def athlete
          extract_entity(get('athlete'), Strava::Models::Athlete)
        end

        #
        # Returns the the authenticated athlete's heart rate and power zones.
        #
        def athlete_zones(options = {})
          extract_entity(get('athlete/zones', options), Strava::Models::Zones)
        end

        #
        # Returns the activity stats of an athlete.
        #
        # @option options [String] :id
        #   Athlete id.
        #
        def athlete_stats(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          extract_entity(get("athletes/#{id}/stats", options), Strava::Models::ActivityStats)
        end

        #
        # Update the currently authenticated athlete.
        #
        # @option options [Float] :weight
        #   The weight of the athlete in kilograms.
        #
        def update_athlete(options = {})
          extract_entity(put('athlete', options), Strava::Models::Athlete)
        end
      end
    end
  end
end

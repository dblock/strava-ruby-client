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
        def athlete_stats(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::ActivityStats.new(get("athletes/#{options[:id]}/stats", options.except(:id)))
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

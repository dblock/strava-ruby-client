# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for Strava athletes.
      #
      # Athletes represent Strava users. This module provides methods for retrieving
      # athlete profiles, stats, zones, and updating athlete information.
      #
      # @see https://developers.strava.com/docs/reference/#api-Athletes
      #
      module Athletes
        #
        # Get the authenticated athlete's profile.
        #
        # Returns the currently authenticated athlete with detailed information.
        # Requires profile:read_all scope for full profile access.
        #
        # @return [Strava::Models::DetailedAthlete] The authenticated athlete
        #
        # @example Get athlete profile
        #   athlete = client.athlete
        #   puts "#{athlete.firstname} #{athlete.lastname}"
        #   puts "Location: #{athlete.city}, #{athlete.state}"
        #
        # @see https://developers.strava.com/docs/reference/#api-Athletes-getLoggedInAthlete
        #
        def athlete
          Strava::Models::DetailedAthlete.new(get('athlete'))
        end

        #
        # Get the authenticated athlete's heart rate and power zones.
        #
        # Returns the athlete's configured training zones for heart rate and power.
        # These zones are used for training analysis and activity classification.
        #
        # @param [Hash] options Additional options
        #
        # @return [Strava::Models::Zones] Athlete zones including heart rate and power
        #
        # @example Get athlete zones
        #   zones = client.athlete_zones
        #   heart_rate = zones.heart_rate
        #   heart_rate.zones.each { |zone| puts "#{zone.min}-#{zone.max} bpm" }
        #
        # @see https://developers.strava.com/docs/reference/#api-Athletes-getLoggedInAthleteZones
        #
        def athlete_zones(options = {})
          Strava::Models::Zones.new(get('athlete/zones', options))
        end

        #
        # Get activity statistics for an athlete.
        #
        # Returns the activity stats of an athlete including recent totals, year-to-date totals,
        # and all-time totals for different activity types.
        #
        # @param [Integer, Hash] id_or_options Athlete ID or options hash with :id key
        # @param [Hash] options Additional options
        #
        # @return [Strava::Models::ActivityStats] Activity statistics
        #
        # @example Get athlete stats
        #   stats = client.athlete_stats(12345)
        #   recent_run = stats.recent_run_totals
        #   puts "Recent runs: #{recent_run.count} totaling #{recent_run.distance_s}"
        #
        # @see https://developers.strava.com/docs/reference/#api-Athletes-getStats
        #
        def athlete_stats(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::ActivityStats.new(get("athletes/#{id}/stats", options))
        end

        #
        # Update the authenticated athlete's profile.
        #
        # Updates the currently authenticated athlete. Only weight can be updated.
        # Requires profile:write scope.
        #
        # @param [Hash] options Athlete attributes to update
        # @option options [Float] :weight Athlete weight in kilograms
        #
        # @return [Strava::Models::DetailedAthlete] The updated athlete profile
        #
        # @example Update athlete weight
        #   athlete = client.update_athlete(weight: 70.5)
        #
        # @see https://developers.strava.com/docs/reference/#api-Athletes-updateLoggedInAthlete
        #
        def update_athlete(options = {})
          Strava::Models::DetailedAthlete.new(put('athlete', options))
        end
      end
    end
  end
end

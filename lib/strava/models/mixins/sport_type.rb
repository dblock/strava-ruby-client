# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      #
      # Provides sport type handling and sport-specific formatting.
      #
      # This mixin adds the sport_type property and provides sport-aware formatting
      # for distance and pace. For example, swimming activities display distance in
      # meters and pace per 100m, while other activities use kilometers and pace per km.
      #
      # Also provides emoji representations for various sport types.
      #
      # @example Using sport type helpers
      #   activity = client.activity(1234567890)
      #   puts activity.sport_type           # => "Run"
      #   puts activity.distance_s            # => "10.0km" (or "500m" for swim)
      #   puts activity.pace_s                # => "4m30s/km" (or "1m20s/100m" for swim)
      #   puts activity.sport_type_emoji      # => "🏃"
      #
      module SportType
        extend ActiveSupport::Concern

        included do
          # @return [String] Activity sport type (e.g., "Run", "Ride", "Swim", "Hike")
          # @note This replaces the deprecated 'type' property
          property 'sport_type'
        end

        #
        # Returns distance formatted appropriately for the sport type.
        #
        # Swimming activities display distance in meters, while all other
        # activities use kilometers.
        #
        # @return [String, nil] Formatted distance
        #
        def distance_s
          if sport_type == 'Swim'
            distance_in_meters_s
          else
            distance_in_kilometers_s
          end
        end

        #
        # Returns pace formatted appropriately for the sport type.
        #
        # Swimming activities display pace per 100 meters, while all other
        # activities use pace per kilometer.
        #
        # @return [String, nil] Formatted pace
        #
        def pace_s
          case sport_type
          when 'Swim'
            pace_per_100_meters_s
          else
            pace_per_kilometer_s
          end
        end

        #
        # Returns an emoji representing the sport type.
        #
        # @return [String, nil] Emoji character or nil if no emoji for this sport
        #
        def sport_type_emoji
          case sport_type
          when 'AlpineSki' then '⛷️'
          when 'BackcountrySki' then '🎿️'
          # when "Canoeing" then ''
          # when "Crossfit" then ''
          # when "Elliptical" then ''
          when 'Golf' then '🏌️'
          # when "Handcycle" then ''
          when 'Hike' then '🥾'
          when 'IceSkate' then '⛸'
          when 'InlineSkate' then "\u{1F6FC}"
          # when "Kayaking" then ''
          # when "Kitesurf" then ''
          when 'MountainBikeRide', 'EMountainBikeRide' then '🚵'
          # when "NordicSki" then ''
          when 'Ride', 'EBikeRide', 'VirtualRide', 'GravelRide' then '🚴'
          when 'RockClimbing' then '🧗'
          # when 'RollerSki' then ''
          when 'Rowing' then '🚣'
          when 'Run', 'VirtualRun', 'TrailRun' then '🏃'
          when 'Sail' then '⛵️'
          when 'Skateboard' then '🛹'
          when 'Snowboard' then '🏂'
          # when 'Snowshoe' then ''
          when 'Soccer' then '⚽️'
          # when 'StairStepper' then ''
          # when 'StandUpPaddling' then ''
          when 'Surfing' then '🏄'
          when 'Swim' then '🏊'
          # when 'Velomobile' then ''
          when 'Walk' then '🚶'
          when 'WeightTraining' then '🏋️'
          when 'Wheelchair' then '♿'
          # when 'Windsurf' then ''
          # when 'Workout' then ''
          when 'Yoga' then '🧘'
          end
        end
      end
    end
  end
end

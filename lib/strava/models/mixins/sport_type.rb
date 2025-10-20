# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module SportType
        extend ActiveSupport::Concern

        included do
          # deprecated, property 'type'
          property 'sport_type'
        end

        def distance_s
          if sport_type == 'Swim'
            distance_in_meters_s
          else
            distance_in_kilometers_s
          end
        end

        def pace_s
          case sport_type
          when 'Swim'
            pace_per_100_meters_s
          else
            pace_per_kilometer_s
          end
        end

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

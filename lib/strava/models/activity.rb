module Strava
  module Models
    class Activity < Model
      property 'id'
      property 'resource_state'
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
      property 'name'
      property 'description'
      property 'distance'
      alias distance_in_meters distance
      property 'moving_time'
      property 'elapsed_time'
      property 'total_elevation_gain'
      property 'type'
      property 'workout_type'
      property 'id'
      property 'external_id'
      property 'upload_id'
      property 'start_date', transform_with: ->(v) { Time.parse(v) }
      property 'start_date_local', transform_with: ->(v) { Time.parse(v) }
      property 'timezone'
      property 'utc_offset'
      property 'start_latlng'
      property 'end_latlng'
      property 'location_city'
      property 'location_state'
      property 'location_country'
      property 'start_latitude'
      property 'start_longitude'
      property 'achievement_count'
      property 'kudos_count'
      property 'comment_count'
      property 'athlete_count'
      property 'photo_count'
      property 'map', transform_with: ->(v) { Strava::Models::Map.new(v) }
      property 'trainer'
      property 'commute'
      property 'manual'
      property 'private'
      property 'visibility'
      property 'flagged'
      property 'gear_id'
      property 'from_accepted_tag'
      property 'average_speed'
      property 'max_speed'
      property 'has_heartrate'
      property 'average_heartrate'
      property 'max_heartrate'
      property 'heartrate_opt_out'
      property 'display_hide_heartrate_option'
      property 'elev_high'
      property 'elev_low'
      property 'pr_count'
      property 'total_photo_count'
      property 'has_kudoed'
      property 'suffer_score'
      property 'calories'
      property 'segment_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::SegmentEffort.new(r) } }
      property 'best_efforts', transform_with: ->(v) { v.map { |r| Strava::Models::SegmentEffort.new(r) } }
      property 'photos', transform_with: ->(v) { Strava::Models::Photos.new(v) }
      property 'similar_activities', transform_with: ->(v) { Strava::Models::SimilarActivities.new(v) }
      property 'embed_token'
      property 'available_zones'
      property 'splits_metric', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }
      property 'splits_standard', transform_with: ->(v) { v.map { |r| Strava::Models::Split.new(r) } }
      property 'laps', transform_with: ->(v) { v.map { |r| Strava::Models::Lap.new(r) } }
      property 'gear', transform_with: ->(v) { Strava::Models::Gear.new(v) }
      property 'device_name'

      def distance_in_miles
        distance * 0.00062137
      end

      def distance_in_miles_s
        return unless distance && distance.positive?

        format('%gmi', format('%.2f', distance_in_miles))
      end

      def distance_in_yards
        distance * 1.09361
      end

      def distance_in_yards_s
        return unless distance && distance.positive?

        format('%gyd', format('%.1f', distance_in_yards))
      end

      def distance_in_meters_s
        return unless distance && distance.positive?

        format('%gm', format('%d', distance))
      end

      def distance_in_kilometers
        distance / 1000
      end

      def distance_in_kilometers_s
        return unless distance && distance.positive?

        format('%gkm', format('%.2f', distance_in_kilometers))
      end

      def distance_s(units = :mi)
        if type == 'Swim'
          case units
          when :km then distance_in_meters_s
          when :mi then distance_in_yards_s
          end
        else
          case units
          when :km then distance_in_kilometers_s
          when :mi then distance_in_miles_s
          end
        end
      end

      def moving_time_in_hours_s
        time_in_hours_s moving_time
      end

      def elapsed_time_in_hours_s
        time_in_hours_s elapsed_time
      end

      def pace_per_mile_s
        convert_meters_per_second_to_pace average_speed, :mi
      end

      def pace_per_100_yards_s
        convert_meters_per_second_to_pace average_speed, :"100yd"
      end

      def pace_per_100_meters_s
        convert_meters_per_second_to_pace average_speed, :"100m"
      end

      def pace_per_kilometer_s
        convert_meters_per_second_to_pace average_speed, :km
      end

      def kilometer_per_hour_s
        return unless average_speed && average_speed.positive?

        format('%.1fkm/h', average_speed * 3.6)
      end

      def miles_per_hour_s
        return unless average_speed && average_speed.positive?

        format('%.1fmph', average_speed * 2.23694)
      end

      def total_elevation_gain_in_feet
        total_elevation_gain_in_meters * 3.28084
      end

      def total_elevation_gain_in_meters
        total_elevation_gain
      end

      def total_elevation_gain_in_meters_s
        return unless total_elevation_gain && total_elevation_gain.positive?

        format('%gm', format('%.1f', total_elevation_gain_in_meters))
      end

      def total_elevation_gain_in_feet_s
        return unless total_elevation_gain && total_elevation_gain.positive?

        format('%gft', format('%.1f', total_elevation_gain_in_feet))
      end

      def total_elevation_gain_s(units = :mi)
        case units
        when :km then total_elevation_gain_in_meters_s
        when :mi then total_elevation_gain_in_feet_s
        end
      end

      def pace_s(units = :mi)
        case type
        when 'Swim'
          case units
          when :km then pace_per_100_meters_s
          when :mi then pace_per_100_yards_s
          end
        else
          case units
          when :km then pace_per_kilometer_s
          when :mi then pace_per_mile_s
          end
        end
      end

      def speed_s(units = :mi)
        case units
        when :km then kilometer_per_hour_s
        when :mi then miles_per_hour_s
        end
      end

      def strava_url
        "https://www.strava.com/activities/#{id}"
      end

      def type_emoji
        case type
        when 'Run' then '🏃'
        when 'Ride' then '🚴'
        when 'Swim' then '🏊'
        when 'Walk' then '🚶'
        when 'AlpineSki' then '⛷️'
        when 'BackcountrySki' then '🎿️'
        # when 'Canoeing' then ''
        # when 'Crossfit' then ''
        when 'EBikeRide' then '🚴'
        # when 'Elliptical' then ''
        # when 'Hike' then ''
        when 'IceSkate' then '⛸️'
        # when 'InlineSkate' then ''
        # when 'Kayaking' then ''
        # when 'Kitesurf' then ''
        # when 'NordicSki' then ''
        when 'RockClimbing' then '🧗'
        when 'RollerSki' then ''
        when 'Rowing' then '🚣'
        when 'Snowboard' then '🏂'
        # when 'Snowshoe' then ''
        # when 'StairStepper' then ''
        # when 'StandUpPaddling' then ''
        when 'Surfing' then '🏄'
        when 'VirtualRide' then '🚴'
        when 'VirtualRun' then '🏃'
        when 'WeightTraining' then '🏋️'
        # when 'Windsurf' then ''
        when 'Wheelchair' then '♿'
          # when 'Workout' then ''
          # when 'Yoga'' then ''
        end
      end

      private

      def time_in_hours_s(time)
        return unless time

        hours = time / 3600 % 24
        minutes = time / 60 % 60
        seconds = time % 60
        [
          hours.to_i.positive? ? format('%dh', hours) : nil,
          minutes.to_i.positive? ? format('%dm', minutes) : nil,
          seconds.to_i.positive? ? format('%ds', seconds) : nil
        ].compact.join
      end

      # Convert speed (m/s) to pace (min/mile or min/km) in the format of 'x:xx'
      # http://yizeng.me/2017/02/25/convert-speed-to-pace-programmatically-using-ruby
      def convert_meters_per_second_to_pace(speed, unit = :mi)
        return unless speed && speed.positive?

        total_seconds = case unit
                        when :mi then 1609.344 / speed
                        when :km then 1000 / speed
                        when :"100yd" then 91.44 / speed
                        when :"100m" then 100 / speed
                        end
        minutes, seconds = total_seconds.divmod(60)
        seconds = seconds.round
        if seconds == 60
          minutes += 1
          seconds = 0
        end
        seconds = seconds < 10 ? "0#{seconds}" : seconds.to_s
        "#{minutes}m#{seconds}s/#{unit}"
      end
    end
  end
end

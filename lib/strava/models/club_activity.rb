# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an activity posted to a club feed.
    #
    # Club activities are a simplified view of activities shared with a club.
    # Note that Strava does not return activity or athlete IDs via this API endpoint,
    # so you cannot link directly to the full activity or athlete profile.
    #
    # Includes helper mixins for formatting distance, time, elevation, and sport type.
    #
    # @example List club activities
    #   activities = client.club_activities(12345)
    #   activities.each do |activity|
    #     puts "#{activity.athlete.name}: #{activity.name}"
    #     puts "#{activity.distance_s} in #{activity.moving_time_in_hours_s}"
    #     puts "#{activity.sport_type_emoji} #{activity.workout_type}"
    #   end
    #
    # @see https://developers.strava.com/docs/reference/#api-models-ClubActivity
    #
    class ClubActivity < Strava::Models::Response
      include Mixins::ElevationGain
      include Mixins::SportType

      # @return [MetaAthlete] Athlete who posted the activity (without ID)
      property 'athlete', transform_with: ->(v) { Strava::Models::MetaAthlete.new(v) }

      # @return [String] Activity name
      property 'name'

      include Mixins::Distance
      include Mixins::MovingTime
      include Mixins::ElapsedTime
      include Mixins::TotalElevationGain
      include Mixins::SportType

      # @return [Integer, nil] Workout type (0=default, 1=race, 2=long run, 3=intervals, etc.)
      property 'workout_type'

      # @return [Integer] Resource state indicator
      property 'resource_state'
    end
  end
end

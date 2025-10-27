# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents the response from updating an activity.
    #
    # When you update an activity using the update_activity endpoint, Strava returns
    # this model containing the fields that were successfully updated. This is a subset
    # of the full activity data.
    #
    # @see https://developers.strava.com/docs/reference/#api-models-UpdatableActivity Strava API UpdatableActivity reference
    # @see Strava::Api::Client#update_activity
    # @see Strava::Models::DetailedActivity
    #
    # @example Updating activity properties
    #   updated = client.update_activity(1234567890,
    #     name: "Morning Run",
    #     description: "Great weather today!",
    #     commute: false,
    #     trainer: false,
    #     gear_id: "g12345"
    #   )
    #
    #   puts "Activity renamed to: #{updated.name}"
    #   puts "Gear ID: #{updated.gear_id}"
    #
    class UpdatableActivity < Strava::Models::Response
      # @return [Boolean, nil] Whether this activity is a commute
      property 'commute'

      # @return [Boolean, nil] Whether this activity was done on a trainer/treadmill
      property 'trainer'

      # @return [Boolean, nil] Whether to hide this activity from the home feed
      property 'hide_from_home'

      # @return [String, nil] Description of the activity
      property 'description'

      # @return [String, nil] Name/title of the activity
      property 'name'

      # @return [String, nil] Sport type (e.g., "Run", "Ride", "Swim")
      property 'sport_type'

      # @return [String, nil] ID of the gear (shoes/bike) used for this activity
      property 'gear_id'
    end
  end
end

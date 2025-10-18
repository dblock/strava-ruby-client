# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-UpdatableActivity
    class UpdatableActivity < Strava::Models::Response
      property 'commute'
      property 'trainer'
      property 'hide_from_home'
      property 'description'
      property 'name'
      property 'sport_type'
      property 'gear_id'
    end
  end
end

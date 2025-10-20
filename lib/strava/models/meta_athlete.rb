# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-MetaAthlete
    class MetaAthlete < Strava::Models::Response
      property 'id'
      # undocumented
      property 'resource_state'
      property 'firstname'
      property 'lastname'
    end
  end
end

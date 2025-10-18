# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-MetaClub
    class MetaClub < Strava::Models::Response
      property 'id'
      property 'resource_state'
      property 'name'
    end
  end
end

# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-MetaActivity
    class MetaActivity < Strava::Models::Response
      property 'id'
      # undocumented
      property 'resource_state'
      property 'visibility'
    end
  end
end

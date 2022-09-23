# frozen_string_literal: true

module Strava
  module Models
    class Achievement < Strava::Models::Response
      property 'rank'
      property 'type'
      property 'type_id'
    end
  end
end

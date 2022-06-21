# frozen_string_literal: true

module Strava
  module Models
    class Achievement < Response
      property 'rank'
      property 'type'
      property 'type_id'
    end
  end
end

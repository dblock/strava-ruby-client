# frozen_string_literal: true

module Strava
  module Models
    class Authorization < Strava::Models::Response
      property 'access_token'
    end
  end
end

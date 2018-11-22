module Strava
  module Models
    class Token < Model
      property 'token_type'
      property 'access_token'
      property 'refresh_token'
      property 'expires_in'
      property 'expires_at', transform_with: ->(v) { Time.at(v) }
      property 'athlete', transform_with: ->(v) { Strava::Models::Athlete.new(v) }
    end
  end
end

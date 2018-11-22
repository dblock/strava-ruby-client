module Strava
  module Models
    class Athlete < Model
      property 'badge_type_id'
      property 'city'
      property 'country'
      property 'created_at'
      property 'email'
      property 'firstname'
      property 'follower'
      property 'friend'
      property 'id'
      property 'lastname'
      property 'premium'
      property 'profile'
      property 'profile_medium'
      property 'resource_state'
      property 'sex'
      property 'state'
      property 'summit'
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      property 'username'
    end
  end
end

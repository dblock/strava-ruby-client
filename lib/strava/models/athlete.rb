module Strava
  module Models
    class Athlete < Model
      property 'id'
      property 'username'
      property 'resource_state'
      property 'firstname'
      property 'lastname'
      property 'city'
      property 'state'
      property 'country'
      property 'sex'
      property 'premium'
      property 'created_at', transform_with: ->(v) { Time.parse(v) }
      property 'updated_at', transform_with: ->(v) { Time.parse(v) }
      property 'badge_type_id'
      property 'profile'
      property 'profile_medium'
      property 'email'
      property 'follower'
      property 'friend'
      property 'summit'
    end
  end
end

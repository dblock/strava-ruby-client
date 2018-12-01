module Strava
  module Models
    class ClubMember < Model
      property 'resource_state'
      property 'firstname'
      property 'lastname'
      property 'owner'
      property 'admin'
      property 'membership'

      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end
    end
  end
end

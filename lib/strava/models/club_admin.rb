# frozen_string_literal: true

module Strava
  module Models
    class ClubAdmin < Strava::Models::Response
      property 'resource_state'
      property 'firstname'
      property 'lastname'

      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end
    end
  end
end

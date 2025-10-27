# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an athlete within a club context.
    #
    # This model provides athlete information along with their club membership
    # status, showing whether they are a regular member, administrator, or owner.
    #
    # @example List club members
    #   members = client.club_members(12345)
    #   members.each do |member|
    #     puts member.name
    #     puts "Admin" if member.admin
    #     puts "Owner" if member.owner
    #   end
    #
    # @see https://developers.strava.com/docs/reference/#api-models-ClubAthlete
    #
    class ClubAthlete < Strava::Models::Response
      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [String] Athlete's first name
      property 'firstname'

      # @return [String] Athlete's last name
      property 'lastname'

      # @return [String, nil] Membership type (e.g., "member")
      property 'member'

      # @return [Boolean] Whether athlete is a club administrator
      property 'admin'

      # @return [Boolean] Whether athlete is the club owner
      property 'owner'

      # @return [String, nil] Membership status or type
      property 'membership'

      #
      # Returns the athlete's full name.
      #
      # @return [String, nil] Full name combining firstname and lastname, or nil if neither exists
      #
      def name
        [firstname, lastname].compact.join(' ') if firstname || lastname
      end
    end
  end
end

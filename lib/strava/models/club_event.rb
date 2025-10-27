# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a club group event or ride.
    #
    # Club events are organized group activities where club members can join
    # to ride, run, or participate together. Events can be recurring and may
    # include a specific route.
    #
    # @example List club events
    #   events = client.club_events(12345)
    #   events.each do |event|
    #     puts event.title
    #     puts event.description
    #     puts "Organized by: #{event.organizing_athlete.name}"
    #     puts "Activity type: #{event.activity_type}"
    #     puts "Next occurrence: #{event.upcoming_occurrences.first}"
    #     puts event.strava_url
    #   end
    #
    # @see Strava::Api::Client#club_events
    #
    class ClubEvent < Strava::Models::Response
      # @return [Integer] Event identifier
      property 'id'

      # @return [Integer] Resource state indicator
      property 'resource_state'

      # @return [String] Event title
      property 'title'

      # @return [String] Event description
      property 'description'

      # @return [Integer] Club identifier
      property 'club_id'

      # @return [SummaryClub] The club hosting this event
      property 'club', transform_with: ->(c) { Strava::Models::SummaryClub.new(c) }

      # @return [SummaryAthlete] Athlete organizing the event
      property 'organizing_athlete', transform_with: ->(oa) { Strava::Models::SummaryAthlete.new(oa) }

      # @return [String] Type of activity (e.g., "Ride", "Run")
      property 'activity_type'

      # @return [Time] When the event was created
      property 'created_at', transform_with: ->(v) { Time.parse(v) if v&.length&.positive? }

      # @return [Integer, nil] Associated route identifier
      property 'route_id'

      # @return [Route, nil] Associated route details
      property 'route', transform_with: ->(r) { Strava::Models::Route.new(r) }

      # @return [Boolean] Whether event is for women only
      property 'women_only'

      # @return [Boolean] Whether event is private
      property 'private'

      # @return [Array<Integer>] Skill levels for participants (0-5 scale)
      property 'skill_levels'

      # @return [Array<Integer>] Terrain types (e.g., road, trail, mixed)
      property 'terrain'

      # @return [Array<Time>] Upcoming scheduled occurrences of this event
      property 'upcoming_occurrences', transform_with: ->(upcoming) { upcoming.map { |o| Time.parse(o) } }

      # @return [String] Timezone for the event
      property 'zone'

      # @return [String] Event meeting address
      property 'address'

      # @return [Boolean] Whether authenticated athlete has joined this event
      property 'joined'

      # @return [LatLng] Starting location coordinates
      property 'start_latlng', transform_with: ->(v) { Strava::Models::LatLng.new(v) }

      #
      # Returns the Strava web URL for this event.
      #
      # @return [String] Full URL to view the event on Strava.com
      #
      def strava_url
        "https://www.strava.com/clubs/#{club_id}/group_events/#{id}"
      end
    end
  end
end

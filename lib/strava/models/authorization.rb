# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an authorization deauthorization response.
    #
    # This model is returned when revoking access to an athlete's data.
    # It contains the access token that was revoked.
    #
    # @example Deauthorize an athlete
    #   authorization = client.deauthorize
    #   puts "Revoked token: #{authorization.access_token}"
    #
    # @see Strava::Api::Client#deauthorize
    #
    class Authorization < Strava::Models::Response
      # @return [String] The access token that was revoked
      property 'access_token'
    end
  end
end

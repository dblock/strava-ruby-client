# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an OAuth token response from Strava.
    #
    # This model is returned when exchanging an authorization code for an access token
    # or when refreshing an expired token. It contains the access token, refresh token,
    # expiration time, and basic athlete information.
    #
    # Tokens expire after a period of time (typically 6 hours). When a token expires,
    # use the refresh_token to obtain a new access_token via the OAuth flow.
    #
    # @example Inspecting token information
    #   token = client.oauth_token(code: 'auth_code')
    #   puts "Access Token: #{token.access_token}"
    #   puts "Refresh Token: #{token.refresh_token}"
    #   puts "Expires at: #{token.expires_at}"
    #   puts "Athlete: #{token.athlete.firstname} #{token.athlete.lastname}"
    #
    # @see Strava::OAuth::Client#oauth_token
    # @see https://developers.strava.com/docs/authentication/
    #
    class Token < Strava::Models::Response
      # @return [String] Type of token, typically "Bearer"
      property 'token_type'

      # @return [String] OAuth access token for API authentication
      property 'access_token'

      # @return [String] Refresh token for obtaining new access tokens
      property 'refresh_token'

      # @return [Integer] Number of seconds until token expires
      property 'expires_in'

      # @return [Time] Expiration time of the access token
      property 'expires_at', transform_with: ->(v) { Time.at(v) }

      # @return [Strava::Models::SummaryAthlete] Summary of the authenticated athlete
      property 'athlete', transform_with: ->(v) { Strava::Models::SummaryAthlete.new(v) }
    end
  end
end

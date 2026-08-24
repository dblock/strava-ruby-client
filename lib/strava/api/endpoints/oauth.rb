# frozen_string_literal: true

module Strava
  module Api
    module Endpoints
      #
      # API endpoints for OAuth operations.
      #
      # OAuth endpoints provide functionality for managing OAuth access tokens,
      # including the ability to revoke an athlete's access token and deauthorize
      # an application's access to their data.
      #
      # @see https://developers.strava.com/docs/authentication/
      #
      module OAuth
        #
        # Revoke access to an athlete's data.
        #
        # Revokes the athlete's access token. After calling this method, the
        # access token will no longer be valid and the athlete will need to
        # reauthorize the application.
        #
        # @param options [Hash] Additional options for the revocation request
        #
        # @return [Authorization] Authorization response with revocation confirmation
        #
        # @example Revoke access for the current athlete
        #   client.revoke
        #
        # @see https://developers.strava.com/docs/authentication/#deauthorization
        #
        def revoke(options = {})
          Strava::Models::Authorization.new(post('revoke', { endpoint: Strava::OAuth.config.endpoint }.merge(options)))
        end

        #
        # Revoke access to an athlete's data.
        #
        # Deauthorizes the application and revokes the athlete's access token.
        # After calling this method, the access token will no longer be valid
        # and the athlete will need to reauthorize the application.
        #
        # @param options [Hash] Additional options for the deauthorization request
        #
        # @return [Authorization] Authorization response with revocation confirmation
        #
        # @example Deauthorize the current athlete
        #   client.deauthorize
        #
        # @deprecated Use {#revoke} instead. The `oauth/deauthorize` endpoint will
        #   be retired on June 1, 2027 in favor of the new `oauth/revoke` endpoint.
        #
        # @see https://developers.strava.com/docs/authentication/#deauthorization
        #
        def deauthorize(options = {})
          Strava::Models::Authorization.new(post('deauthorize', { endpoint: Strava::OAuth.config.endpoint }.merge(options)))
        end
      end
    end
  end
end

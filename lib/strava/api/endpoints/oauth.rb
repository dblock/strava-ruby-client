module Strava
  module Api
    module Endpoints
      module OAuth
        #
        # Revoke access to an athlete's data.
        #
        def deauthorize(options = {})
          Strava::Models::Authorization.new(post('deauthorize', { endpoint: Strava::OAuth.config.endpoint }.merge(options)))
        end
      end
    end
  end
end

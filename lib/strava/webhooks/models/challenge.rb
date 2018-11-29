module Strava
  module Webhooks
    module Models
      class Challenge < Hashie::Trash
        property 'mode', from: 'hub.mode'
        property 'verify_token', from: 'hub.verify_token'
        property 'challenge', from: 'hub.challenge'

        def response
          { 'hub.challenge' => challenge }
        end
      end
    end
  end
end

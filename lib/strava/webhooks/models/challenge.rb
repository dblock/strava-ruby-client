# frozen_string_literal: true

module Strava
  module Webhooks
    module Models
      #
      # Represents a webhook subscription validation challenge.
      #
      # When creating a webhook subscription, Strava sends a GET request to your
      # callback URL with challenge parameters. Your application must validate the
      # verify_token and respond with the challenge value.
      #
      # @example Handle webhook challenge in Rails
      #   def webhook
      #     if request.get?
      #       challenge = Strava::Webhooks::Models::Challenge.new(request.query_parameters)
      #       if challenge.verify_token == ENV['STRAVA_VERIFY_TOKEN']
      #         render json: challenge.response
      #       else
      #         head :forbidden
      #       end
      #     end
      #   end
      #
      # @example Handle challenge in Sinatra
      #   get '/webhook' do
      #     challenge = Strava::Webhooks::Models::Challenge.new(params)
      #     halt 403 unless challenge.verify_token == ENV['STRAVA_VERIFY_TOKEN']
      #     content_type :json
      #     challenge.response.to_json
      #   end
      #
      # @see Strava::Webhooks::Client#create_push_subscription
      # @see https://developers.strava.com/docs/webhooks/
      #
      class Challenge < Hashie::Trash
        # @return [String] Subscription mode, typically "subscribe"
        property 'mode', from: 'hub.mode'

        # @return [String] Verification token to validate the request
        property 'verify_token', from: 'hub.verify_token'

        # @return [String] Challenge value that must be echoed back
        property 'challenge', from: 'hub.challenge'

        #
        # Returns the response hash that should be sent back to Strava.
        #
        # @return [Hash] Response containing the challenge value
        #
        def response
          { 'hub.challenge' => challenge }
        end
      end
    end
  end
end

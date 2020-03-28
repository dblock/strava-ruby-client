module Strava
  module Webhooks
    module Config
      extend self

      ATTRIBUTES = %i[
        endpoint
        client_id
        client_secret
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset
        self.endpoint = 'https://www.strava.com/api/v3'
        self.client_id = nil
        self.client_secret = nil
      end
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end

Strava::Webhooks::Config.reset

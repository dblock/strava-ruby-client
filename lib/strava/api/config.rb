# frozen_string_literal: true

module Strava
  module Api
    module Config
      extend self

      ATTRIBUTES = %i[
        endpoint
        access_token
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset
        self.endpoint = 'https://www.strava.com/api/v3'
        self.access_token = nil
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

Strava::Api::Config.reset

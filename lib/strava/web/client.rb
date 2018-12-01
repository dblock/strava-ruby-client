module Strava
  module Web
    class Client
      include Web::Connection
      include Web::Request

      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        Strava::Web::Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Web.config.send(key))
        end
        @logger ||= Strava::Logger.logger
      end

      def endpoint
        raise NotImplementedError
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
end

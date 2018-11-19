module Strava
  class Client
    include Faraday::Connection
    include Faraday::Request

    attr_accessor(*Config::ATTRIBUTES)

    def initialize(options = {})
      Strava::Config::ATTRIBUTES.each do |key|
        send("#{key}=", options[key] || Strava.config.send(key))
      end
      @logger ||= Strava::Config.logger || Strava::Logger.default
      @token ||= Strava.config.token
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

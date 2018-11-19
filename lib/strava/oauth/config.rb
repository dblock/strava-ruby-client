module Strava
  module OAuth
    module Config
      def reset
        self.endpoint = 'https://www.strava.com/oauth/'
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

Strava::Config.reset

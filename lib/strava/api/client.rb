module Strava
  module Api
    class Client < Strava::Web::Client
      attr_accessor(*Config::ATTRIBUTES)

      def initialize(options = {})
        Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Api.config.send(key))
        end
        super
      end

      def headers
        { 'Authorization' => "Bearer #{access_token}" }
      end

      def athlete
        Strava::Models::Athlete.new(get('athlete'))
      end

      def athlete_activities(options = {})
        get('athlete/activities', options).map do |activity|
          Strava::Models::Activity.new(activity)
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
end

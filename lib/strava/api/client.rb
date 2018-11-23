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

      def athlete_activities(options = {}, &block)
        paginate 'athlete/activities', options, Strava::Models::Activity, &block
      end

      class << self
        def configure
          block_given? ? yield(Config) : Config
        end

        def config
          Config
        end
      end

      private

      def paginate(path, options, model, &_block)
        if block_given?
          Cursor.new(self, path, options).each do |page|
            page.each do |row|
              yield model.new(row)
            end
          end
        else
          get(path, options).map do |row|
            model.new(row)
          end
        end
      end
    end
  end
end

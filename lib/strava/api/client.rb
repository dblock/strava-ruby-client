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

      #
      # Get logged-in athlete.
      #
      def athlete
        Strava::Models::Athlete.new(get('athlete'))
      end

      #
      # List logged-in athlete activities.
      #
      def athlete_activities(options = {}, &block)
        paginate 'athlete/activities', options, Strava::Models::Activity, &block
      end

      #
      # Create an activity.
      #
      def create_activity(options = {})
        Strava::Models::Activity.new(post('activities', options))
      end

      #
      # List logged-in athlete clubs.
      #
      def athlete_clubs(options = {}, &block)
        paginate 'athlete/clubs', options, Strava::Models::Club, &block
      end

      #
      # List club activities.
      #
      # @option options [String] :id
      #   Club id.
      #
      def club_activities(options = {}, &block)
        throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
        paginate "clubs/#{options[:id]}/activities", options.except(:id), Strava::Models::Activity, &block
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

      def paginate(path, options, model)
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

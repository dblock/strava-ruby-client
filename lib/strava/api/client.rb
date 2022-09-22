# frozen_string_literal: true

module Strava
  module Api
    class Client < Strava::Web::Client
      include Endpoints::Activities
      include Endpoints::Athletes
      include Endpoints::Clubs
      include Endpoints::Gears
      include Endpoints::Routes
      include Endpoints::RunningRaces
      include Endpoints::SegmentEfforts
      include Endpoints::Segments
      include Endpoints::Streams
      include Endpoints::Uploads
      include Endpoints::OAuth

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
        collection = []
        api_response = nil
        if block_given?
          Cursor.new(self, path, options).each do |page|
            api_response = page # response of the last request made
            page.each do |row|
              m = model.new(row)
              yield m
              collection << m
            end
          end

        else
          api_response = get(path, options)
          collection = api_response.map do |row|
            model.new(row)
          end
        end
        Pagination.new(collection, api_response)
      end
    end
  end
end

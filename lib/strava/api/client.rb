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

      def enrich_model_with_headers(model, response)
        response.ratelimit_headers
        model._response_headers = response.headers
        model._response_ratelimit = response.ratelimit_headers
        model
      end

      def extract_entity(response, model)
        m = model.new(response.body)
        enrich_model_with_headers(m, response)
      end

      def extract_entities(response, model)
        response.body.each do |row|
          m = model.new(row)
          enrich_model_with_headers(m, response)
          yield m
        end
       end

      def paginate(path, options, model)
        if block_given?
          Cursor.new(self, path, options).each do |page|
            extract_entities(page, model) do |e|
              yield e
            end
          end
        else
          response = get(path, options)
          extract_entities(response, model)
        end
      end
    end
  end
end

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

      def parse_args(id_or_options, options = {})
        if id_or_options.is_a?(Hash)
          throw ArgumentError.new('Required argument :id missing') if id_or_options[:id].nil?
          [id_or_options[:id], id_or_options.except(:id)]
        else
          throw ArgumentError.new('Required argument :id missing') if id_or_options.nil?
          [id_or_options, options]
        end
      end
    end
  end
end

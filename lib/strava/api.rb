module Strava
  module Api
    ROOT_URI = 'https://www.strava.com/api/v3'.freeze

    def self.default_connection(path)
      Faraday.new(
        url: "#{ROOT_URI}/#{path}",
        request: {
          params_encoder: Faraday::FlatParamsEncoder
        }
      ) do |c|
        c.use ::FaradayMiddleware::ParseJson
        c.use Faraday::Response::RaiseError
        c.use Faraday::Adapter::NetHttp
      end
    end
  end
end

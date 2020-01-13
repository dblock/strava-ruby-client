module Strava
  module Web
    module Response
      class RaiseError < ::Faraday::Response::Middleware
        ClientErrorStatuses = (400...600).freeze

        def on_complete(env)
          handle_upload_errors(env) if env.method == :post && env.url.path.end_with?('/uploads')

          case env[:status]
          when 404
            raise Faraday::Error::ResourceNotFound, response_values(env)
          when 407
            # mimic the behavior that we get with proxy requests with HTTPS
            raise Faraday::Error::ConnectionFailed, %(407 "Proxy Authentication Required ")
          when ClientErrorStatuses
            raise Strava::Errors::Fault, response_values(env)
          end
        end

        def handle_upload_errors(env)
          raise Strava::Errors::UploadFailed, response_values(env) if env.status != 201 && env.body.key?('error') && !env.body['error'].blank?
        end

        def response_values(env)
          {
            status: env.status,
            headers: env.response_headers,
            body: env.body
          }
        end
      end
    end
  end
end

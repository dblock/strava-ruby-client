# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module HttpResponse
        extend ActiveSupport::Concern

        attr_accessor :http_response

        def ratelimit
          http_response.ratelimit
        end

        included do
          property 'http_response', transform_with: ->(v) { Strava::Web::ApiResponse.new(v) }
        end
      end
    end
  end
end

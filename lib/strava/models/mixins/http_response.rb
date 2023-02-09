# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module HttpResponse
        extend ActiveSupport::Concern

        included do
          attr_reader :input

          def initialize(obj)
            @input = obj
            super
          end

          def http_response
            @http_response ||= Strava::Web::ApiResponse.new(input['http_response'])
          end
        end
      end
    end
  end
end

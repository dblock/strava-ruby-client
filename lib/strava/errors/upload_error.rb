# frozen_string_literal: true

module Strava
  module Errors
    class UploadError < ::Faraday::ClientError
      def status
        response[:status]
      end

      def headers
        response[:headers]
      end

      def message
        body[:error] || super
      end

      def error_status
        body[:status]
      end

      def upload
        @upload ||= Strava::Models::Upload.new(body)
      end

      private

      def body
        (response[:body] || {}).with_indifferent_access
      end
    end
  end
end

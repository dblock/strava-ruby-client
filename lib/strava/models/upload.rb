# frozen_string_literal: true

module Strava
  module Models
    # https://developers.strava.com/docs/reference/#api-models-Upload
    class Upload < Strava::Models::Response
      property 'id'
      property 'id_str'
      property 'external_id'
      property 'error'
      property 'status'
      property 'activity_id'

      def processing?
        validate!
        activity_id.nil?
      end

      def processed?
        !processing?
      end

      private

      def validate!
        raise_when_background_job_failed!
      end

      def raise_when_background_job_failed!
        response = http_response.response
        return unless response_contains_error_message?(response)

        raise Strava::Errors::UploadError, response_values(response)
      end

      def response_contains_error_message?(response)
        response.status == 200 && response.body['error'].present?
      end

      def response_values(response)
        {
          status: response.status,
          headers: response.headers,
          body: response.body
        }
      end
    end
  end
end

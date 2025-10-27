# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents an activity file upload status.
    #
    # When uploading activity files (GPX, TCX, FIT) to Strava, the upload is processed
    # asynchronously. This model tracks the upload status and provides helper methods
    # to check if processing is complete.
    #
    # @example Upload and poll for completion
    #   upload = client.create_upload(
    #     file: Faraday::UploadIO.new('activity.gpx', 'application/gpx+xml'),
    #     data_type: 'gpx'
    #   )
    #
    #   while upload.processing?
    #     sleep 2
    #     upload = client.upload(upload.id)
    #   end
    #
    #   if upload.error
    #     puts "Upload failed: #{upload.error}"
    #   else
    #     puts "Activity created: #{upload.activity_id}"
    #   end
    #
    # @see Strava::Api::Client#create_upload
    # @see Strava::Api::Client#upload
    # @see https://developers.strava.com/docs/reference/#api-models-Upload
    #
    class Upload < Strava::Models::Response
      # @return [Integer] Upload ID
      property 'id'

      # @return [String] Upload ID as string
      property 'id_str'

      # @return [String] External identifier for the upload
      property 'external_id'

      # @return [String, nil] Error message if upload failed
      property 'error'

      # @return [String] Status message (e.g., "Your activity is ready.", "Your activity is still being processed.")
      property 'status'

      # @return [Integer, nil] Activity ID once processing is complete
      property 'activity_id'

      #
      # Checks if the upload is still processing.
      #
      # @return [Boolean] true if upload is still being processed
      # @raise [Strava::Errors::UploadError] if upload failed with an error
      #
      def processing?
        validate!
        activity_id.nil?
      end

      #
      # Checks if the upload has completed processing.
      #
      # @return [Boolean] true if upload processing is complete
      #
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

# frozen_string_literal: true

module Strava
  module Errors
    #
    # Exception raised when an activity upload fails.
    #
    # When uploading activity files (FIT, TCX, GPX) to Strava, the API processes
    # the file asynchronously and may encounter errors during processing. This
    # exception is raised when the upload fails, and includes information about
    # the upload status and error details.
    #
    # The error provides access to the upload model, which contains detailed
    # information about what went wrong during the upload processing.
    #
    # @see Strava::Models::Upload
    # @see https://developers.strava.com/docs/reference/#api-Uploads
    #
    class UploadError < ::Faraday::ClientError
      #
      # Returns the HTTP response status code.
      #
      # @return [Integer] The HTTP status code
      #
      def status
        response[:status]
      end

      #
      # Returns the HTTP response headers.
      #
      # @return [Hash] The response headers hash
      #
      def headers
        response[:headers]
      end

      #
      # Returns the error message from the upload response.
      #
      # Extracts the error message from the response body's 'error' field,
      # or falls back to the parent class message if not available.
      #
      # @return [String] The error message
      #
      def message
        body[:error] || super
      end

      #
      # Returns the upload processing status from the response.
      #
      # The upload status indicates where in the processing pipeline the
      # upload failed (e.g., 'error', 'processing', 'ready').
      #
      # @return [String] The upload status
      #
      def error_status
        body[:status]
      end

      #
      # Returns the upload model containing detailed upload information.
      #
      # The upload model includes fields like id, external_id, error,
      # status, and activity_id (if the upload succeeded before encountering
      # an error).
      #
      # @return [Strava::Models::Upload] The upload model
      #
      def upload
        @upload ||= Strava::Models::Upload.new(body)
      end

      private

      #
      # Returns the response body with indifferent access.
      #
      # @api private
      # @return [HashWithIndifferentAccess] The response body hash
      #
      def body
        (response[:body] || {}).with_indifferent_access
      end
    end
  end
end

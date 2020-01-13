module Strava
  module Errors
    class UploadFailed < ::Faraday::ClientError
      def upload
        Strava::Models::Upload.new(response[:body])
      end
    end
  end
end

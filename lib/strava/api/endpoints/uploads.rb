module Strava
  module Api
    module Endpoints
      module Uploads
        #
        # Uploads a new data file to create an activity from.
        #
        # @option options [File] :file
        #   The uploaded file.
        # @option options [String] :name
        #   The desired name of the resulting activity.
        # @option options [String] :description
        #   The desired description of the resulting activity.
        # @option options [Boolean] :trainer
        #   Whether the resulting activity should be marked as having been performed on a trainer.
        # @option options [Boolean] :commute
        #   Whether the resulting activity should be tagged as a commute.
        # @option options [String] :data_type
        #   The format of the uploaded file.
        # @option options [String] :external_id
        #   The desired external identifier of the resulting activity.
        #
        def create_upload(options = {})
          Strava::Models::Upload.new(post('uploads', options))
        end

        #
        # Returns an upload for a given identifier.
        #
        # @option options [String] :id
        #   The identifier of the upload.
        #
        def upload(id_or_options, options = {})
          id, options = parse_args(id_or_options, options)
          Strava::Models::Upload.new(get("uploads/#{id}", options))
        end
      end
    end
  end
end

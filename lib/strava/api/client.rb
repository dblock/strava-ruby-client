# frozen_string_literal: true

module Strava
  module Api
    #
    # Main API client for interacting with the Strava API v3.
    #
    # This class provides a complete Ruby interface to the Strava API, including support for:
    # * Activities (create, read, update, list)
    # * Athletes (profile, stats, zones)
    # * Clubs (details, members, activities)
    # * Gear (equipment details)
    # * Routes (details, GPX/TCX export)
    # * Segments and Segment Efforts
    # * Streams (activity, route, segment data)
    # * Uploads (activity file uploads)
    # * OAuth (token refresh, deauthorization)
    #
    # @example Create a client with an access token
    #   client = Strava::Api::Client.new(access_token: "your_access_token")
    #   athlete = client.athlete
    #   activities = client.athlete_activities(per_page: 10)
    #
    # @example Configure globally
    #   Strava::Api::Client.configure do |config|
    #     config.access_token = "your_access_token"
    #   end
    #   client = Strava::Api::Client.new
    #
    # @see https://developers.strava.com/docs/reference/ Strava API Documentation
    #
    class Client < Strava::Web::Client
      include Endpoints::Activities
      include Endpoints::Athletes
      include Endpoints::Clubs
      include Endpoints::Gears
      include Endpoints::Routes
      include Endpoints::SegmentEfforts
      include Endpoints::Segments
      include Endpoints::Streams
      include Endpoints::Uploads
      include Endpoints::OAuth

      attr_accessor(*Config::ATTRIBUTES)

      #
      # Initialize a new API client.
      #
      # @param [Hash] options Configuration options for the client
      # @option options [String] :access_token OAuth access token for API authentication (required)
      # @option options [String] :endpoint API endpoint URL (defaults to https://www.strava.com/api/v3)
      # @option options [String] :user_agent User agent string for HTTP requests
      # @option options [Logger] :logger Logger instance for request/response logging
      # @option options [Integer] :timeout HTTP request timeout in seconds
      # @option options [Integer] :open_timeout HTTP connection timeout in seconds
      # @option options [String] :proxy HTTP proxy URL
      # @option options [String] :ca_path Path to SSL CA certificates
      # @option options [String] :ca_file Path to SSL CA certificate file
      #
      # @example
      #   client = Strava::Api::Client.new(
      #     access_token: "your_access_token",
      #     user_agent: "My Strava App/1.0"
      #   )
      #
      def initialize(options = {})
        Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Api.config.send(key))
        end
        super
      end

      #
      # Returns HTTP headers for API requests.
      #
      # @return [Hash] Headers including OAuth bearer token authorization
      # @api private
      #
      def headers
        { 'Authorization' => "Bearer #{access_token}" }
      end

      class << self
        #
        # Configure the API client globally.
        #
        # @yield [Config] Configuration object
        # @return [Strava::Api::Config] Configuration object
        #
        # @example
        #   Strava::Api::Client.configure do |config|
        #     config.access_token = "your_access_token"
        #   end
        #
        def configure
          block_given? ? yield(Config) : Config
        end

        #
        # Returns the configuration object.
        #
        # @return [Strava::Api::Config] Configuration object
        #
        def config
          Config
        end
      end

      private

      #
      # Paginates requests using per_page.
      #
      # @param [String] path url for request
      # @param [Hash] options hash containing settings
      # @param [Class] model by Class
      #
      # @example
      #   paginate("athlete/activities", {per_page: 72}, Strava::Models::Activity)
      #
      # @return [Strava::Api::Pagination]
      #
      def paginate(path, options, model, &block)
        raise ArgumentError, 'per_page' if options.key(:page_size)

        paginate_with_cursor(path, options, model, &block)
      end

      #
      # Paginates requests using a cursor, using per_page or page_size.
      #
      # @param [String] path url for request
      # @param [Hash] options hash containing settings
      # @param [Class] model by Class
      #
      # @example
      #   paginate("activity/comments", {page_size: 72}, Strava::Models::Comment)
      #   paginate("athlete/activities", {per_page: 72}, Strava::Models::Activity)
      #
      # @return [Strava::Api::Pagination]
      #
      def paginate_with_cursor(path, options, model)
        # avoid retrieving unnecessary items
        if options.key?(:limit)
          if options.key?(:per_page) && options[:per_page] > options[:limit]
            options = options.merge(per_page: options[:limit])
          elsif options.key?(:page_size) && options[:page_size] > options[:limit]
            options = options.merge(page_size: options[:limit])
          end
        end

        collection = []
        web_response = nil

        if block_given? || options.key?(:page_size) || options.key?(:per_page)
          Cursor.new(self, path, options).each do |page|
            web_response = page # response of the last request made
            page.each do |row|
              break if options.key?(:limit) && collection.size >= options[:limit]

              m = model.new(row)
              yield m if block_given?
              collection << m
            end
            break if options.key?(:limit) && collection.size >= options[:limit]
          end
        else
          page_options = if options.key?(:limit)
                           options.dup.tap do |copy|
                             copy[:page_size] = copy.delete(:limit)
                           end
                         else
                           options
                         end
          web_response = get(path, page_options)
          collection = web_response.map do |row|
            break if options.key?(:limit) && collection.size >= options[:limit]

            model.new(row)
          end
        end
        Pagination.new(collection, web_response)
      end
    end
  end
end

# frozen_string_literal: true

module Strava
  module Api
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

      def initialize(options = {})
        Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Strava::Api.config.send(key))
        end
        super
      end

      def headers
        { 'Authorization' => "Bearer #{access_token}" }
      end

      class << self
        def configure
          block_given? ? yield(Config) : Config
        end

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
        options = options.merge(per_page: options[:limit]) if options.key?(:per_page) && options.key(:limit) && options[:per_page] > options[:limit]
        options = options.merge(page_size: options[:limit]) if options.key?(:page_size) && options.key(:limit) && options[:page_size] > options[:limit]
        collection = []
        web_response = nil
        if block_given? || options.key?(:page_size) || options.key(:per_page)
          Cursor.new(self, path, options).each do |page|
            web_response = page # response of the last request made
            page.each do |row|
              break if options.key?(:limit) && collection.size >= options[:limit]

              m = model.new(row)
              yield m if block_given?
              collection << m
            end
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

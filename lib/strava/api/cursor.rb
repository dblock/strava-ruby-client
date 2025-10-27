# frozen_string_literal: true

module Strava
  module Api
    #
    # Handles paginated iteration through API endpoints.
    #
    # This class provides an Enumerable interface for iterating through
    # paginated API responses. It supports both traditional page-based
    # pagination and cursor-based pagination.
    #
    # @see Strava::Api::Pagination
    #
    # @example Iterating through pages
    #   cursor = Strava::Api::Cursor.new(client, 'athlete/activities', per_page: 30)
    #   cursor.each do |page|
    #     page.each do |activity|
    #       puts activity.name
    #     end
    #   end
    #
    class Cursor
      include Enumerable

      # @return [Strava::Api::Client] API client instance
      attr_reader :client

      # @return [String] API endpoint path
      attr_reader :path

      # @return [Hash] Query parameters for the request
      attr_reader :params

      #
      # Initialize a new Cursor for paginated iteration.
      #
      # @param client [Strava::Api::Client] API client to use for requests
      # @param path [String] API endpoint path to paginate
      # @param params [Hash] Query parameters (excluding :limit which is removed)
      #
      def initialize(client, path, params = {})
        @client = client
        @path = path
        @params = params.key?(:limit) ? params.dup.tap { |p| p.delete :limit } : params
      end

      def each(&block)
        params[:page_size] ? each_cursor(&block) : each_page(&block)
      end

      private

      def each_page
        next_page = 1
        loop do
          query = params.merge(page: next_page)
          response = client.get(path, query)
          break unless response.any?

          yield response
          next_page += 1
        end
      end

      def each_cursor
        cursor = nil
        query = params
        loop do
          response = client.get(path, query)
          break unless response.any?

          yield response

          break if response.size < params[:page_size]

          cursor = response.last&.[]('cursor')
          break unless cursor.present?

          query = params.merge(after_cursor: cursor)
        end
      end
    end
  end
end

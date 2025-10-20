# frozen_string_literal: true

module Strava
  module Api
    class Cursor
      include Enumerable

      attr_reader :client, :path, :params

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

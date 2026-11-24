# frozen_string_literal: true

require 'faraday/logging/formatter'

module Strava
  module Web
    #
    # Formats request and response logs, adding a blank line after headers
    # to separate them from the next log entry.
    #
    class LogFormatter < ::Faraday::Logging::Formatter
      private

      def dump_headers(headers)
        dumped = super
        "#{dumped}\n" if dumped
      end
    end
  end
end

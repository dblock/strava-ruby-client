# frozen_string_literal: true

module Strava
  module Web
    #
    # Faraday response middleware that parses JSON response bodies.
    #
    # This is a drop-in replacement for Faraday's built-in +:json+ response
    # middleware (+Faraday::Response::Json+), which calls
    # +JSON.parse(body, options)+ with a positional options hash. The
    # +json+ gem 3.0 changed +JSON.parse+ to accept options as keyword
    # arguments only, so that call raises
    # +ArgumentError: wrong number of arguments (given 2, expected 1)+,
    # surfaced by Faraday as +Faraday::ParsingError+.
    #
    # Overriding +#parse+ to call +JSON.parse+ with a single argument
    # keeps this gem working with both +json+ < 3.0 and +json+ >= 3.0.
    #
    # @see https://github.com/dblock/strava-ruby-client/issues/113
    # @api private
    #
    class JsonResponse < ::Faraday::Response::Json
      private

      def parse(body)
        return if body.strip.empty?

        ::JSON.parse(body)
      end
    end
  end
end

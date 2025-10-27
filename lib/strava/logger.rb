# frozen_string_literal: true

require 'logger'

module Strava
  #
  # Default logger for the Strava client library.
  #
  # Extends the standard Ruby Logger class and provides a default logger
  # instance configured to output warnings and errors to STDOUT. The logger
  # can be customized via the Web configuration to control HTTP request/response
  # logging.
  #
  # @example Using the default logger
  #   Strava::Logger.logger.info('Making API request')
  #
  # @example Customizing the logger
  #   Strava::Web.configure do |config|
  #     config.logger = Logger.new('strava.log')
  #   end
  #
  # @see Logger
  #
  class Logger < ::Logger
    #
    # Returns the default logger instance.
    #
    # Creates a memoized logger that outputs to STDOUT with a default
    # log level of WARN. This logger is used by default for HTTP request
    # logging unless overridden in the configuration.
    #
    # @return [Strava::Logger] The default logger instance
    #
    def self.logger
      @logger ||= begin
        logger = new $stdout
        logger.level = Logger::WARN
        logger
      end
    end
  end
end

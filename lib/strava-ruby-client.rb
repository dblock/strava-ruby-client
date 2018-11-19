require 'faraday'
require 'faraday_middleware'
require 'json'
require 'logger'

require_relative 'strava/faraday/connection'
require_relative 'strava/faraday/request'

require_relative 'strava/version'
require_relative 'strava/logger'
require_relative 'strava/config'
require_relative 'strava/client'

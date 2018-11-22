require 'faraday'
require 'faraday_middleware'
require 'json'
require 'logger'
require 'hashie'
require 'active_support/core_ext/object/to_query'

require_relative 'strava/version'
require_relative 'strava/logger'

require_relative 'strava/models/model'
require_relative 'strava/models/athlete'
require_relative 'strava/models/token'

require_relative 'strava/web/connection'
require_relative 'strava/web/request'
require_relative 'strava/web/config'
require_relative 'strava/web/client'

require_relative 'strava/oauth/config'
require_relative 'strava/oauth/client'

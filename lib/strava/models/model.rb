require 'pry'
module Strava
  class Model < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    attr_accessor :_response_headers, :_response_ratelimit
  end
end

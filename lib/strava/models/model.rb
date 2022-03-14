# frozen_string_literal: true

module Strava
  class Model < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
  end
end

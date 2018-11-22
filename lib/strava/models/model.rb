module Strava
  class Model < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
  end
end

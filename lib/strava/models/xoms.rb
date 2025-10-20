# frozen_string_literal: true

module Strava
  module Models
    # Undocumented
    class Xoms < Strava::Models::Response
      property 'kom'
      property 'qom'
      property 'overall'
      property 'destination', transform_with: ->(v) { Strava::Models::Destination.new(v) }
    end
  end
end

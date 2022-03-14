# frozen_string_literal: true

module Strava
  module Models
    class Upload < Model
      property 'id'
      property 'external_id'
      property 'error'
      property 'status'
      property 'activity_id'
    end
  end
end

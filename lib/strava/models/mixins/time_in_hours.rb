# frozen_string_literal: true

module Strava
  module Models
    module Mixins
      module TimeInHours
        extend ActiveSupport::Concern

        private

        def time_in_hours_s(time)
          return unless time

          hours = time / 3600 % 24
          minutes = time / 60 % 60
          seconds = time % 60
          [
            hours.to_i.positive? ? format('%dh', hours) : nil,
            minutes.to_i.positive? ? format('%dm', minutes) : nil,
            seconds.to_i.positive? ? format('%ds', seconds) : nil
          ].compact.join
        end
      end
    end
  end
end

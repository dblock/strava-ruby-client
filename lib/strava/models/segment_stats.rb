# frozen_string_literal: true

module Strava
  module Models
    class SegmentStats < Model
      include Mixins::Time

      property 'pr_elapsed_time'
      property 'pr_date', transform_with: ->(v) { Date.parse(v) }
      property 'effort_count'

      def elapsed_time
        pr_elapsed_time
      end
    end
  end
end

module Strava
  module Api
    module Endpoints
      module Gears
        #
        # Returns an equipment using its identifier.
        #
        # @option options [String] :id
        #   Gear id.
        #
        def gear(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::Gear.new(get("gear/#{options[:id]}", options.except(:id)))
        end
      end
    end
  end
end

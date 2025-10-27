# frozen_string_literal: true

module Strava
  module Models
    #
    # Represents a destination or link reference.
    #
    # Used to provide navigation links to related resources or pages.
    # This model is not documented in the official Strava API reference.
    #
    # @note This model is not documented by Strava API documentation. Properties
    #   are inferred from API responses.
    #
    # @see Strava::Models::Xoms
    # @see Strava::Models::LocalLegend
    #
    # @example Accessing destination information
    #   # From XOMs or local legend data
    #   if xoms.destination
    #     puts "Name: #{xoms.destination.name}"
    #     puts "Type: #{xoms.destination.type}"
    #     puts "Link: #{xoms.destination.href}"
    #   end
    #
    class Destination < Strava::Models::Response
      # @return [String, nil] URL or path to the destination resource
      # @note Not documented by Strava API
      property 'href'

      # @return [String, nil] Type of destination (e.g., "segment")
      # @note Not documented by Strava API
      property 'type'

      # @return [String, nil] Display name of the destination
      # @note Not documented by Strava API
      property 'name'
    end
  end
end

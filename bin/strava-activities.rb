# frozen_string_literal: true

require 'strava-ruby-client'

access_token = ENV['STRAVA_ACCESS_TOKEN'] || raise("Missing ENV['STRAVA_ACCESS_TOKEN'].")

client = Strava::Api::Client.new(
  access_token: access_token
)

client.athlete_activities.each do |activity|
  puts activity.name
end

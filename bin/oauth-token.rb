#!/usr/bin/env ruby

require 'dotenv/load'
require 'strava-ruby-client'

client = Strava::OAuth::Client.new(
  client_id: ENV['STRAVA_CLIENT_ID'],
  client_secret: ENV['STRAVA_CLIENT_SECRET']
)

redirect_url = client.authorize_url(
  redirect_uri: 'http://localhost',
  response_type: 'code',
  scope: 'activity:read'
)

STDOUT.write "Opening browser at #{redirect_url}\n"
system 'open', redirect_url

STDOUT.write 'Copy paste the code from the redirect URL: '
code = gets.strip

response = client.oauth_token(code: code)

puts "token_type: #{response.token_type}"
puts "refresh_token: #{response.refresh_token}"
puts "access_token: #{response.access_token}"
puts "expires_at: #{response.expires_at}"

#!/usr/bin/env ruby

require 'dotenv/load'
require 'strava-ruby-client'
require 'webrick'

server = WEBrick::HTTPServer.new(Port: 4242)

trap 'INT' do
  server.shutdown
end

client = Strava::OAuth::Client.new(
  client_id: ENV['STRAVA_CLIENT_ID'],
  client_secret: ENV['STRAVA_CLIENT_SECRET']
)

server.mount_proc '/' do |req, res|
  code = req.query['code']
  response = client.oauth_token(code: code)

  res.body = %(
<html>
  <body>
    <ul>
      <li>token_type: #{response.token_type}</li>
      <li>refresh_token: #{response.refresh_token}</li>
      <li>access_token: #{response.access_token}</li>
      <li>expires_at: #{response.expires_at}</li>
    </ul>
  <body>
</html>
  )

  server.shutdown
end

redirect_url = client.authorize_url(
  redirect_uri: 'http://localhost:4242/',
  response_type: 'code',
  scope: 'read_all,activity:read_all,profile:read_all'
)

server.logger.info "opening browser at #{redirect_url}\n"
system 'open', redirect_url

server.start

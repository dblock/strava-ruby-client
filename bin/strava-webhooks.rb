#!/usr/bin/env ruby

require 'dotenv/load'
require 'strava-ruby-client'
require 'webrick'

logger = ::Logger.new(STDOUT)
logger.level = Logger::INFO

client = Strava::Webhooks::Client.new(
  client_id: ENV['STRAVA_CLIENT_ID'],
  client_secret: ENV['STRAVA_CLIENT_SECRET'],
  logger: logger
)

case ARGV[0]
when 'create' then
  callback_url = ARGV[1]
  raise 'Missing callback_url.' unless callback_url

  client.logger.info "Subscribing to #{callback_url} ..."
  subscription = client.create_push_subscription(callback_url: callback_url, verify_token: 'token')
  puts subscription
when 'delete'
  id = ARGV[1]
  raise 'Missing id.' unless id

  client.logger.info "Unsubscribing #{id} ..."
  client.delete_push_subscription(id: id)
  client.logger.info 'Done.'
when 'handle'
  server = WEBrick::HTTPServer.new(Port: 4242)

  trap 'INT' do
    server.shutdown
  end

  server.mount_proc '/' do |req, res|
    case req.request_method
    when 'GET' then
      challenge = Strava::Webhooks::Models::Challenge.new(req.query)
      res.content_type = 'application/json'
      res.body = challenge.response.to_json
    when 'POST' then
      event = Strava::Webhooks::Models::Event.new(JSON.parse(req.body))
      server.logger.info event
      res.content_type = 'application/json'
      res.body = { ok: true }.to_json
    end
  end
  server.start
else
  client.push_subscriptions.each do |s|
    puts s
  end
end

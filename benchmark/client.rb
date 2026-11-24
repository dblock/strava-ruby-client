# frozen_string_literal: true

# Benchmarks Strava::Api::Client end to end, from the HTTP response through
# Faraday, JSON parsing, Strava::Web::Response and model construction.
# Responses are replayed with WebMock from the VCR cassettes in spec/fixtures,
# so no network access or Strava token is needed.
#
#   bundle exec rake benchmark
#   bundle exec ruby benchmark/client.rb [scenario ...]

require 'bundler/setup'
require 'benchmark/ips'
require 'webmock'
require 'yaml'
require 'strava-ruby-client'

include WebMock::API # rubocop:disable Style/MixinUsage

WebMock.enable!
WebMock.disable_net_connect!

FIXTURES = File.expand_path('../spec/fixtures/strava/client', __dir__)

def stub_cassette(name, index = 0)
  interaction = YAML.load_file(File.join(FIXTURES, "#{name}.yml"))['http_interactions'][index]
  response = interaction['response']
  stub_request(interaction['request']['method'].to_sym, interaction['request']['uri']).to_return(
    status: response['status']['code'],
    headers: response['headers'].transform_values { |v| v.is_a?(Array) ? v.join(', ') : v },
    body: response['body']['string']
  )
end

stub_cassette('activity')
stub_cassette('all_athlete_activities')
stub_cassette('activity_streams')
stub_cassette('club_events')

client = Strava::Api::Client.new(access_token: 'access-token')

SCENARIOS = {
  'activity' => -> { client.activity(1_946_417_534) },
  'athlete_activities' => -> { client.athlete_activities(page: 1) },
  'activity_streams' => -> { client.activity_streams(1_946_417_534) },
  'club_events' => -> { client.club_events(456_773) }
}.freeze

selected = ARGV.empty? ? SCENARIOS.keys : ARGV
unknown = selected - SCENARIOS.keys
abort "Unknown scenario: #{unknown.join(', ')}. Use one of #{SCENARIOS.keys.join(', ')}." if unknown.any?

puts "Ruby #{RUBY_DESCRIPTION}"
puts "strava-ruby-client #{Strava::VERSION}, hashie #{Hashie::VERSION}, faraday #{Faraday::VERSION}"
puts

puts 'Allocations per call:'
selected.each do |name|
  SCENARIOS[name].call
  GC.start
  before = GC.stat(:total_allocated_objects)
  SCENARIOS[name].call
  puts format('  %-20<name>s %<count>10d objects', name: name, count: GC.stat(:total_allocated_objects) - before)
end
puts

Benchmark.ips do |x|
  x.config(time: Integer(ENV.fetch('BENCHMARK_TIME', 5)), warmup: Integer(ENV.fetch('BENCHMARK_WARMUP', 2)))
  selected.each { |name| x.report(name, &SCENARIOS[name]) }
  x.save!(ENV['BENCHMARK_SAVE']) if ENV['BENCHMARK_SAVE']
  x.compare! if ENV['BENCHMARK_SAVE']
end

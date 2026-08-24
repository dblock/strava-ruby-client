# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/strava'
  config.hook_into :webmock
  #  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
  config.before_record do |i|
    i.request.headers['Authorization'] = ['Bearer access-token'] if ENV.key?('STRAVA_ACCESS_TOKEN')
    i.response.body.force_encoding('UTF-8')
  end
end

RSpec.configure do |config|
  # Specs tagged `:integration` make real network calls and should bypass
  # VCR/WebMock entirely rather than being recorded or stubbed.
  config.around(:each, :integration) do |example|
    VCR.turn_off!
    WebMock.allow_net_connect!
    example.run
    WebMock.disable_net_connect!
    VCR.turn_on!
  end
end

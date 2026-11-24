# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::LogFormatter do
  let(:log) { StringIO.new }
  let(:headers) do
    client.athlete
    log.string.split(/(?=^I, )/).grep(/(?:request|response): [\w-]+: /)
  end

  before do
    Strava::Api::Config.reset
    stub_request(:get, 'https://www.strava.com/api/v3/athlete').to_return(
      status: 200, headers: { 'Content-Type' => 'application/json' }, body: '{}'
    )
  end

  context 'with log_formatter set' do
    let(:client) { Strava::Api::Client.new(access_token: 'access-token', logger: Logger.new(log), log_formatter: described_class) }

    it 'adds a blank line after request and response headers' do
      expect(headers.size).to eq 2
      expect(headers).to all(end_with("\n\n"))
    end

    it 'filters credentials' do
      expect(headers.first).to include('Authorization: "Bearer FILTERED"')
    end
  end

  context 'with log_formatter configured' do
    before { Strava::Web.configure { |config| config.log_formatter = described_class } }
    after { Strava::Web::Config.reset }

    let(:client) { Strava::Api::Client.new(access_token: 'access-token', logger: Logger.new(log)) }

    it 'adds a blank line after headers' do
      expect(headers).to all(end_with("\n\n"))
    end
  end

  context 'without log_formatter' do
    let(:client) { Strava::Api::Client.new(access_token: 'access-token', logger: Logger.new(log)) }

    it 'uses the default Faraday formatter' do
      expect(headers.size).to eq 2
      expect(headers).to all(satisfy { |entry| !entry.end_with?("\n\n") })
    end
  end
end

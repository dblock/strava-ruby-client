# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::Filter do
  describe '.string' do
    it 'filters credential parameters' do
      expect(described_class.string('https://www.strava.com/api/v3/push_subscriptions/1?client_id=123&client_secret=secret')).to eq(
        'https://www.strava.com/api/v3/push_subscriptions/1?client_id=123&client_secret=FILTERED'
      )
      expect(described_class.string('client_id=123&refresh_token=token&code=abc&grant_type=refresh_token')).to eq(
        'client_id=123&refresh_token=FILTERED&code=FILTERED&grant_type=refresh_token'
      )
    end

    it 'does not filter parameters with similar names' do
      expect(described_class.string('zip_code=10001&postcode=10001')).to eq 'zip_code=10001&postcode=10001'
    end

    it 'accepts a URI and nil' do
      expect(described_class.string(URI('https://example.com/?access_token=token'))).to eq 'https://example.com/?access_token=FILTERED'
      expect(described_class.string(nil)).to be_nil
    end
  end

  describe '.params' do
    it 'filters credential values' do
      expect(described_class.params('client_id' => '123', 'client_secret' => 'secret', client_secret: 'secret')).to eq(
        'client_id' => '123', 'client_secret' => 'FILTERED', client_secret: 'FILTERED'
      )
    end
  end

  describe '.headers' do
    it 'filters the Authorization header' do
      expect(described_class.headers('Authorization' => 'Bearer token', 'Accept' => 'application/json')).to eq(
        'Authorization' => 'FILTERED', 'Accept' => 'application/json'
      )
    end
  end

  describe '.body' do
    it 'filters form and hash bodies' do
      expect(described_class.body('client_id=123&client_secret=secret')).to eq 'client_id=123&client_secret=FILTERED'
      expect(described_class.body('client_secret' => 'secret')).to eq('client_secret' => 'FILTERED')
      expect(described_class.body(nil)).to be_nil
    end
  end

  context 'with a Webhooks client' do
    before do
      Strava::Webhooks::Config.reset
      stub_request(:delete, %r{\Ahttps://www.strava.com/api/v3/push_subscriptions/1\?}).to_return(
        status: 404,
        headers: { 'Content-Type' => 'application/json' },
        body: { message: 'Resource Not Found' }.to_json
      )
    end

    let(:client) { Strava::Webhooks::Client.new(client_id: '123', client_secret: 'secret', logger: Logger.new(log)) }
    let(:log) { StringIO.new }

    it 'does not include the client secret in errors or logs' do
      expect { client.delete_push_subscription(id: 1) }.to raise_error(Faraday::ResourceNotFound) do |error|
        expect(error.message).to include('client_secret=FILTERED')
        expect(error.response[:request][:params]['client_secret']).to eq 'FILTERED'
        expect(error.inspect).not_to include('"secret"', '=secret')
      end
      expect(log.string).to include('client_secret=FILTERED')
      expect(log.string).not_to include('=secret')
    end
  end

  context 'with an API client' do
    before do
      Strava::Api::Config.reset
      stub_request(:get, 'https://www.strava.com/api/v3/athlete').to_return(
        status: 401,
        headers: { 'Content-Type' => 'application/json' },
        body: { message: 'Authorization Error' }.to_json
      )
    end

    let(:client) { Strava::Api::Client.new(access_token: 'access-token', logger: Logger.new(log)) }
    let(:log) { StringIO.new }

    it 'does not include the access token in errors or logs' do
      expect { client.athlete }.to raise_error(Strava::Errors::Fault) do |error|
        expect(error.response[:request][:headers]['Authorization']).to eq 'FILTERED'
        expect(error.inspect).not_to include('access-token')
      end
      expect(log.string).to include('Authorization: "Bearer FILTERED"')
      expect(log.string).not_to include('access-token')
    end

    context 'with filter_credentials set to false' do
      let(:client) { Strava::Api::Client.new(access_token: 'access-token', logger: Logger.new(log), filter_credentials: false) }

      it 'includes the access token in errors and logs' do
        expect { client.athlete }.to raise_error(Strava::Errors::Fault) do |error|
          expect(error.response[:request][:headers]['Authorization']).to eq 'Bearer access-token'
        end
        expect(log.string).to include('Authorization: "Bearer access-token"')
      end
    end

    context 'with filter_credentials configured to false' do
      before { Strava::Web.configure { |config| config.filter_credentials = false } }
      after { Strava::Web::Config.reset }

      it 'includes the access token in errors' do
        expect { client.athlete }.to raise_error(Strava::Errors::Fault) do |error|
          expect(error.response[:request][:headers]['Authorization']).to eq 'Bearer access-token'
        end
      end
    end
  end
end

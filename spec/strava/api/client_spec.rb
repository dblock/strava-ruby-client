# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Api::Client do
  let(:client) { described_class.new }

  before do
    Strava::Api::Config.reset
  end

  it_behaves_like 'web client'

  context 'with errors' do
    it 'handles authorization errors', vcr: { cassette_name: 'client/authorization_error' } do
      expect { client.activity(id: 1_946_417_534) }.to raise_error Strava::Errors::Fault, /Authorization Error/
    end

    it 'handles not found errors', vcr: { cassette_name: 'client/not_found_error' } do
      expect { client.activity(id: 1_946_417_534) }.to raise_error Faraday::ResourceNotFound
    end

    it 'includes method url and url_path', vcr: { cassette_name: 'client/not_found_error' } do
      expect { client.activity(id: 1_946_417_534) }.to raise_error Faraday::ResourceNotFound do |error|
        request = error.response[:request]
        expect(request[:method]).to eq :get
        expect(request[:url]).to eq URI('https://www.strava.com/api/v3/activities/1946417534')
        expect(request[:url_path]).to eq '/api/v3/activities/1946417534'
      end
    end

    context 'with DEFAULT_OPTIONS[:include_request] set to false' do
      before do
        allow_any_instance_of(Strava::Web::RaiseResponseError).to receive(:options)
          .and_return({ include_request: false, allowed_statuses: [] })
      end

      it 'does not include method url and url_path in Faraday::ResourceNotFound', vcr: { cassette_name: 'client/not_found_error' } do
        expect { client.activity(id: 1_946_417_534) }.to raise_error Faraday::ResourceNotFound do |error|
          expect(error.response[:request]).to be_nil
        end
      end

      it 'does not include method url and url_path in Strava::Errors::RatelimitError', vcr: { cassette_name: 'client/activity_with_ratelimit_exceeded' } do
        expect do
          client.activity(1_946_417_534)
        end.to raise_error(Strava::Errors::RatelimitError) do |error|
          expect(error.ratelimit).to be_a Strava::Api::Ratelimit
          expect(error.ratelimit.exceeded?).to be(true)
          expect(error.ratelimit.exceeded).to eql({ fifteen_minutes_remaining: 0 })
          expect(error.response[:request]).to be_nil
        end
      end
    end

    it 'raises Strava::Errors::RatelimitError', vcr: { cassette_name: 'client/activity_with_ratelimit_exceeded' } do
      expect do
        client.activity(1_946_417_534)
      end.to raise_error(Strava::Errors::RatelimitError) do |error|
        expect(error.ratelimit).to be_a Strava::Api::Ratelimit
        expect(error.ratelimit.exceeded?).to be(true)
        expect(error.ratelimit.exceeded).to eql({ fifteen_minutes_remaining: 0 })
        request = error.response[:request]
        expect(request[:method]).to eq :get
        expect(request[:url]).to eq URI('https://www.strava.com/api/v3/activities/1946417534')
        expect(request[:url_path]).to eq '/api/v3/activities/1946417534'
      end
    end
  end

  context 'with SSL certificates' do
    context 'when default' do
      let(:client) { described_class.new }

      it 'does not set SSL certs' do
        expect(client.ca_file).to be_nil
        expect(client.ca_path).to be_nil
      end
    end

    context 'when set via constructor' do
      let(:client) { described_class.new(ca_file: OpenSSL::X509::DEFAULT_CERT_FILE, ca_path: OpenSSL::X509::DEFAULT_CERT_DIR) }

      it 'sets SSL certs' do
        expect(client.ca_file).to eq OpenSSL::X509::DEFAULT_CERT_FILE
        expect(client.ca_path).to eq OpenSSL::X509::DEFAULT_CERT_DIR
        expect(client.send(:connection).ssl.ca_file).to eq OpenSSL::X509::DEFAULT_CERT_FILE
        expect(client.send(:connection).ssl.ca_path).to eq OpenSSL::X509::DEFAULT_CERT_DIR
      end
    end

    context 'when set via config' do
      before do
        Strava::Web.configure do |config|
          config.ca_file = OpenSSL::X509::DEFAULT_CERT_FILE
          config.ca_path = OpenSSL::X509::DEFAULT_CERT_DIR
        end
      end

      let(:client) { described_class.new }

      it 'sets SSL certificates' do
        expect(client.send(:connection).ssl.ca_file).to eq OpenSSL::X509::DEFAULT_CERT_FILE
        expect(client.send(:connection).ssl.ca_path).to eq OpenSSL::X509::DEFAULT_CERT_DIR
      end
    end
  end
end

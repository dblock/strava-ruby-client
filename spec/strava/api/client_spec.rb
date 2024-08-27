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

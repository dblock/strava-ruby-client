require 'spec_helper'

RSpec.shared_examples 'web client' do
  before do
    described_class.config.reset
    Strava::Web::Config.reset
  end
  context 'with defaults' do
    let(:client) { described_class.new }
    context '#initialize' do
      it 'implements endpoint' do
        expect(client.endpoint).to_not be nil
      end
      it 'includes default http configuration' do
        expect(client.user_agent).to eq "Strava Ruby Client/#{Strava::VERSION}"
      end
      it 'sets user-agent' do
        expect(client.user_agent).to eq Strava::Web::Config.user_agent
        expect(client.user_agent).to include Strava::VERSION
      end
      it 'caches the Faraday connection to allow persistent adapters' do
        first = client.send(:connection)
        second = client.send(:connection)
        expect(first).to equal second
      end
      (Strava::Web::Config::ATTRIBUTES - [:logger]).each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Strava::Web::Config.send(key)
        end
      end
    end
  end
  context 'with custom settings' do
    context '#initialize' do
      Strava::Web::Config::ATTRIBUTES.each do |key|
        context key.to_s do
          let(:client) { described_class.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Strava::Web::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    let(:client) { described_class.new }
    context 'user-agent' do
      before do
        Strava::Web::Client.configure do |config|
          config.user_agent = 'custom/user-agent'
        end
      end
      context '#initialize' do
        it 'sets user-agent' do
          expect(client.user_agent).to eq 'custom/user-agent'
        end
        it 'creates a connection with the custom user-agent' do
          expect(client.send(:connection).headers).to include(
            'Accept' => 'application/json; charset=utf-8',
            'User-Agent' => 'custom/user-agent'
          )
        end
      end
    end
    context 'proxy' do
      before do
        Strava::Web::Client.configure do |config|
          config.proxy = 'http://localhost:8080'
        end
      end
      context '#initialize' do
        it 'sets proxy' do
          expect(client.proxy).to eq 'http://localhost:8080'
        end
        it 'creates a connection with the proxy' do
          expect(client.send(:connection).proxy.uri.to_s).to eq 'http://localhost:8080'
        end
      end
    end
    context 'SSL options' do
      before do
        Strava::Web::Client.configure do |config|
          config.ca_path = '/ca_path'
          config.ca_file = '/ca_file'
        end
      end
      context '#initialize' do
        it 'sets ca_path and ca_file' do
          expect(client.ca_path).to eq '/ca_path'
          expect(client.ca_file).to eq '/ca_file'
        end
        it 'creates a connection with ssl options' do
          ssl = client.send(:connection).ssl
          expect(ssl.ca_path).to eq '/ca_path'
          expect(ssl.ca_file).to eq '/ca_file'
        end
      end
    end
    context 'logger option' do
      let(:logger) { Logger.new(STDOUT) }
      before do
        Strava::Web::Client.configure do |config|
          config.logger = logger
        end
      end
      context '#initialize' do
        it 'sets logger' do
          expect(client.logger).to eq logger
        end
        it 'creates a connection with a logger' do
          expect(client.send(:connection).builder.handlers).to include ::Faraday::Response::Logger
        end
      end
    end
    context 'timeout options' do
      before do
        Strava::Web::Client.configure do |config|
          config.timeout = 10
          config.open_timeout = 15
        end
      end
      context '#initialize' do
        it 'sets timeout and open_timeout' do
          expect(client.timeout).to eq 10
          expect(client.open_timeout).to eq 15
        end
        it 'creates a connection with timeout options' do
          conn = client.send(:connection)
          expect(conn.options.timeout).to eq 10
          expect(conn.options.open_timeout).to eq 15
        end
      end
    end
  end
end

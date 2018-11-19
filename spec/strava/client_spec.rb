require 'spec_helper'

RSpec.describe Strava::Client do
  before do
    Strava::Config.reset
  end
  context 'with defaults' do
    let(:client) { Strava::Client.new }
    describe '#initialize' do
      it 'sets user-agent' do
        expect(client.user_agent).to eq Strava::Config.user_agent
        expect(client.user_agent).to include Strava::VERSION
      end
      (Strava::Config::ATTRIBUTES - [:logger]).each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Strava::Config.send(key)
        end
      end
    end
  end
  context 'with custom settings' do
    describe '#initialize' do
      Strava::Config::ATTRIBUTES.each do |key|
        context key do
          let(:client) { Strava::Client.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Strava::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    after do
      Strava::Client.config.reset
    end
    let(:client) { Strava::Client.new }
    context 'user-agent' do
      before do
        Strava::Client.configure do |config|
          config.user_agent = 'custom/user-agent'
        end
      end
      describe '#initialize' do
        it 'sets user-agent' do
          expect(client.user_agent).to eq 'custom/user-agent'
        end
        it 'creates a connection with the custom user-agent' do
          expect(client.send(:connection).headers).to eq(
            'Accept' => 'application/json; charset=utf-8',
            'User-Agent' => 'custom/user-agent'
          )
        end
      end
    end
    context 'token' do
      before do
        Strava.configure do |config|
          config.token = 'global default'
        end
      end
      it 'defaults token to global default' do
        client = Strava::Client.new
        expect(client.token).to eq 'global default'
      end
      context 'with web config' do
        before do
          Strava::Client.configure do |config|
            config.token = 'custom web token'
          end
        end
        it 'overrides token to web config' do
          client = Strava::Client.new
          expect(client.token).to eq 'custom web token'
        end
        it 'overrides token to specific token' do
          client = Strava::Client.new(token: 'local token')
          expect(client.token).to eq 'local token'
        end
      end
    end
    context 'proxy' do
      before do
        Strava::Client.configure do |config|
          config.proxy = 'http://localhost:8080'
        end
      end
      describe '#initialize' do
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
        Strava::Client.configure do |config|
          config.ca_path = '/ca_path'
          config.ca_file = '/ca_file'
        end
      end
      describe '#initialize' do
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
        Strava::Client.configure do |config|
          config.logger = logger
        end
      end
      describe '#initialize' do
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
        Strava::Client.configure do |config|
          config.timeout = 10
          config.open_timeout = 15
        end
      end
      describe '#initialize' do
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

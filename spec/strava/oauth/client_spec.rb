require 'spec_helper'

RSpec.describe Strava::OAuth::Client do
  before do
    Strava::OAuth::Config.reset
  end
  it_behaves_like 'web client'
  context 'with defaults' do
    let(:client) { Strava::OAuth::Client.new }
    describe '#initialize' do
      it 'sets endpoint' do
        expect(client.endpoint).to eq 'https://www.strava.com/oauth/'
      end
      Strava::OAuth::Config::ATTRIBUTES.each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Strava::OAuth::Config.send(key)
        end
      end
      context '#authorize_url' do
        it 'requires client id' do
          expect { client.authorize_url }.to raise_error ArgumentError, 'Missing Strava client id.'
        end
      end
    end
  end
  context 'with custom settings' do
    describe '#initialize' do
      Strava::OAuth::Config::ATTRIBUTES.each do |key|
        context key do
          let(:client) { Strava::OAuth::Client.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Strava::OAuth::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    after do
      Strava::OAuth::Client.config.reset
    end
    let(:client) { Strava::OAuth::Client.new }
    context 'client id and secret' do
      before do
        Strava::OAuth::Client.configure do |config|
          config.client_id = 'custom client id'
          config.client_secret = 'custom client secret'
        end
      end
      describe '#initialize' do
        it 'sets client id and secret' do
          expect(client.client_id).to eq 'custom client id'
          expect(client.client_secret).to eq 'custom client secret'
        end
      end
    end
  end
  context 'with a client id and secret' do
    let(:client) { Strava::OAuth::Client.new(client_id: '12345', client_secret: 'client-secret') }
    context '#authorize_url' do
      it 'returns url' do
        expect(client.authorize_url).to eq 'https://www.strava.com/oauth/authorize?approval_prompt=auto&client_id=12345&redirect_uri=http%3A%2F%2Flocalhost&response_type=code&scope=read'
      end
      it 'returns url with custom options' do
        expect(client.authorize_url(
                 redirect_uri: 'https://example.com/oauth',
                 approval_prompt: 'force',
                 response_type: 'code',
                 scope: 'activity:read_all',
                 state: 'magic'
               )).to eq 'https://www.strava.com/oauth/authorize?approval_prompt=force&client_id=12345&redirect_uri=https%3A%2F%2Fexample.com%2Foauth&response_type=code&scope=activity%3Aread_all&state=magic'
      end
    end
    context '#oauth_token' do
      it 'errors with an invalid client id', vcr: { cassette_name: 'oauth_token_invalid_client' } do
        expect { client.oauth_token(code: 'code') }.to raise_error Faraday::ClientError do |e|
          expect(e.response[:body]['errors']).to eq([{ 'code' => 'invalid', 'field' => 'client_id', 'resource' => 'Application' }])
        end
      end
      it 'errors with an invalid code', vcr: { cassette_name: 'oauth_token_invalid_code' } do
        expect { client.oauth_token(code: 'code') }.to raise_error Faraday::ClientError do |e|
          expect(e.response[:body]['errors']).to eq([{ 'code' => 'invalid', 'field' => 'code', 'resource' => 'RequestToken' }])
        end
      end
      it 'performs the initial token exchange', vcr: { cassette_name: 'oauth_token_authorization_code' } do
        expect(client.oauth_token(code: 'deadbeef585a6edb1f00309d3e1e0fec74973fb0')).to eq(
          'access_token' => 'deadbeefd7ab44704fb2a146bd98c7a349a2b43d',
          'athlete' => {
            'badge_type_id' => 1,
            'city' => 'New York',
            'country' => '',
            'created_at' => '2017-11-28T19:05:35Z',
            'email' => 'dblock@example.com',
            'firstname' => 'Daniel',
            'follower' => nil,
            'friend' => nil,
            'id' => 12_342_176,
            'lastname' => 'Block',
            'premium' => true,
            'profile' => 'https://dgalywyr863hv.cloudfront.net/pictures/athletes/26462176/7677115/2/large.jpg', 'profile_medium' => 'https://dgalywyr863hv.cloudfront.net/pictures/athletes/26462176/7677115/2/medium.jpg',
            'resource_state' => 2,
            'sex' => 'M',
            'state' => 'NY',
            'summit' => true,
            'updated_at' => '2018-11-19T01:44:15Z',
            'username' => 'dblockdotorg'
          },
          'expires_at' => 1_542_940_199,
          'expires_in' => 21_600,
          'refresh_token' => 'deadbeef9d64b225d0c50db4854a8d6c8757702d',
          'token_type' => 'Bearer'
        )
      end
    end
  end
end

require 'spec_helper'

RSpec.describe Strava::Webhooks::Client do
  before do
    Strava::Webhooks::Config.reset
  end
  it_behaves_like 'web client'
  context 'with defaults' do
    let(:client) { Strava::Webhooks::Client.new }
    describe '#initialize' do
      it 'sets endpoint' do
        expect(client.endpoint).to eq 'https://api.strava.com/api/v3'
      end
      Strava::Webhooks::Config::ATTRIBUTES.each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq Strava::Webhooks::Config.send(key)
        end
      end
    end
  end
  context 'with custom settings' do
    describe '#initialize' do
      Strava::Webhooks::Config::ATTRIBUTES.each do |key|
        context key do
          let(:client) { Strava::Webhooks::Client.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq Strava::Webhooks::Config.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    after do
      Strava::Webhooks::Client.config.reset
    end
    let(:client) { Strava::Webhooks::Client.new }
    context 'client id and secret' do
      before do
        Strava::Webhooks::Client.configure do |config|
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
    let(:client) { Strava::Webhooks::Client.new(client_id: ENV['STRAVA_CLIENT_ID'] || '24523', client_secret: ENV['STRAVA_CLIENT_SECRET'] || 'client-secret') }
    context '#push_subscriptions' do
      it 'gets an empty set of push subscriptions', vcr: { cassette_name: 'webhooks/no_push_subscriptions' } do
        subscriptions = client.push_subscriptions
        expect(subscriptions).to eq([])
      end
      it 'creates a subscription', vcr: { cassette_name: 'webhooks/create_push_subscription' } do
        subscription = client.create_push_subscription(callback_url: 'http://35d43b4e.ngrok.io/', verify_token: 'verify-token')
        expect(subscription).to be_a Strava::Webhooks::Models::Subscription
        expect(subscription.application_id).to eq 24_523
        expect(subscription.callback_url).to eq 'http://35d43b4e.ngrok.io/'
        expect(subscription.id).to eq 131_300
        expect(subscription.created_at).to be_a Time
        expect(subscription.updated_at).to be_a Time
      end
      it 'returns subscriptions', vcr: { cassette_name: 'webhooks/push_subscriptions' } do
        subscriptions = client.push_subscriptions
        expect(subscriptions).to be_a Enumerable
        expect(subscriptions.count).to eq 1
        subscription = subscriptions.first
        expect(subscription).to be_a Strava::Webhooks::Models::Subscription
        expect(subscription.application_id).to eq 24_523
        expect(subscription.callback_url).to eq 'http://35d43b4e.ngrok.io/'
        expect(subscription.id).to eq 131_300
        expect(subscription.created_at).to be_a Time
        expect(subscription.updated_at).to be_a Time
      end
      it 'deletes a subscription', vcr: { cassette_name: 'webhooks/delete_push_subscription' } do
        subscription = client.delete_push_subscription(id: 131_300)
        expect(subscription).to be nil
      end
    end
  end
end

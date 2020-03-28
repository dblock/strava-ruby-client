require 'spec_helper'

describe Strava::Webhooks::Config do
  describe '#defaults' do
    it 'sets endpoint' do
      expect(Strava::Webhooks.config.endpoint).to eq 'https://www.strava.com/api/v3'
      expect(Strava::Webhooks.config.client_id).to be nil
      expect(Strava::Webhooks.config.client_secret).to be nil
    end
  end
  describe '#configure' do
    before do
      Strava::Webhooks.configure do |config|
        config.client_id = 'client id'
        config.client_secret = 'client secret'
      end
    end
    it 'sets client id and secret' do
      expect(Strava::Webhooks.config.endpoint).to eq 'https://www.strava.com/api/v3'
      expect(Strava::Webhooks.config.client_id).to eq 'client id'
      expect(Strava::Webhooks.config.client_secret).to eq 'client secret'
    end
  end
end

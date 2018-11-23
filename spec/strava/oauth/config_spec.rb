require 'spec_helper'

describe Strava::OAuth::Config do
  describe '#defaults' do
    it 'sets endpoint' do
      expect(Strava::OAuth.config.endpoint).to eq 'https://www.strava.com/oauth'
      expect(Strava::OAuth.config.client_id).to be nil
      expect(Strava::OAuth.config.client_secret).to be nil
    end
  end
  describe '#configure' do
    before do
      Strava::OAuth.configure do |config|
        config.client_id = 'client id'
        config.client_secret = 'client secret'
      end
    end
    it 'sets client id and secret' do
      expect(Strava::OAuth.config.endpoint).to eq 'https://www.strava.com/oauth'
      expect(Strava::OAuth.config.client_id).to eq 'client id'
      expect(Strava::OAuth.config.client_secret).to eq 'client secret'
    end
  end
end

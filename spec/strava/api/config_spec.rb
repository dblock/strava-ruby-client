require 'spec_helper'

describe Strava::Api::Config do
  before do
    Strava::Api.config.reset
  end
  describe '#defaults' do
    it 'sets endpoint' do
      expect(Strava::Api.config.endpoint).to eq 'https://www.strava.com/api/v3'
    end
  end
  describe '#configure' do
    before do
      Strava::Api.configure do |config|
        config.endpoint = 'updated'
      end
    end
    it 'sets endpoint' do
      expect(Strava::Api.config.endpoint).to eq 'updated'
    end
  end
end

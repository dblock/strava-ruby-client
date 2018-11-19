require 'spec_helper'

describe Strava::Config do
  describe '#configure' do
    before do
      Strava.configure do |config|
        config.token = 'a token'
      end
    end
    it 'sets token' do
      expect(Strava.config.token).to eq 'a token'
    end
  end
end

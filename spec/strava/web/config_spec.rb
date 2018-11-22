require 'spec_helper'

describe Strava::Web::Config do
  describe '#configure' do
    before do
      Strava::Web.configure do |config|
        config.token = 'a token'
      end
    end
    it 'sets token' do
      expect(Strava::Web.config.token).to eq 'a token'
    end
  end
end

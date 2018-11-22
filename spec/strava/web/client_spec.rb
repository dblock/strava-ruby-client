require 'spec_helper'

describe Strava::Web::Client do
  describe '#endpoint' do
    it 'is not implemented' do
      expect { subject.endpoint }.to raise_error NotImplementedError
    end
  end
end

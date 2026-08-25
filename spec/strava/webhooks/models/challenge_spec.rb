# frozen_string_literal: true

require 'spec_helper'

describe Strava::Webhooks::Models::Challenge do
  describe '#response' do
    it 'returns a hash with the challenge value' do
      challenge = described_class.new('hub.mode' => 'subscribe', 'hub.verify_token' => 'token', 'hub.challenge' => 'abc123')
      expect(challenge.mode).to eq 'subscribe'
      expect(challenge.verify_token).to eq 'token'
      expect(challenge.response).to eq('hub.challenge' => 'abc123')
    end
  end
end

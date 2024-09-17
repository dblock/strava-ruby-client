# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::Client do
  let(:client) { described_class.new }

  describe '#endpoint' do
    it 'is not implemented' do
      expect { client.endpoint }.to raise_error NotImplementedError
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::Client do
  let(:client) { described_class.new }

  before do
    Strava::Web::Config.reset
  end

  describe '.configure' do
    after do
      described_class.config.user_agent = "Strava Ruby Client/#{Strava::VERSION}"
    end

    it 'yields the config when a block is given' do
      described_class.configure do |config|
        config.user_agent = 'my-app'
      end
      expect(described_class.config.user_agent).to eq 'my-app'
    end

    it 'returns the config when no block is given' do
      expect(described_class.configure).to eq Strava::Web::Config
    end
  end

  describe '#endpoint' do
    it 'is not implemented' do
      expect { client.endpoint }.to raise_error NotImplementedError
    end
  end

  describe '#parse_args' do
    it 'returns id and options from a hash' do
      expect(client.parse_args(id: '12345', per_page: 10)).to eq(['12345', { per_page: 10 }])
    end

    it 'returns id and options when given separately' do
      expect(client.parse_args('12345', per_page: 10)).to eq(['12345', { per_page: 10 }])
    end

    it 'raises an error when :id is missing from a hash' do
      expect { client.parse_args(per_page: 10) }.to raise_error ArgumentError, 'Required argument :id missing'
    end

    it 'raises an error when id_or_options is nil' do
      expect { client.parse_args(nil) }.to raise_error ArgumentError, 'Required argument :id missing'
    end
  end
end

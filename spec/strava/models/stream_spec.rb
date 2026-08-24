# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::Stream do
  describe '#total_elevation_gain' do
    it 'sums positive elevation changes' do
      stream = described_class.new('data' => [100, 105, 102, 110, 108])
      expect(stream.total_elevation_gain).to eq 13
    end

    it 'returns 0 when there is no elevation gain' do
      stream = described_class.new('data' => [100, 90, 80])
      expect(stream.total_elevation_gain).to eq 0
    end

    it 'returns nil when data is nil' do
      stream = described_class.new(nil)
      expect(stream.total_elevation_gain).to be_nil
    end
  end

  describe '#total_elevation_loss' do
    it 'sums negative elevation changes' do
      stream = described_class.new('data' => [100, 105, 102, 110, 108])
      expect(stream.total_elevation_loss).to eq 5
    end

    it 'returns 0 when there is no elevation loss' do
      stream = described_class.new('data' => [80, 90, 100])
      expect(stream.total_elevation_loss).to eq 0
    end

    it 'returns nil when data is nil' do
      stream = described_class.new(nil)
      expect(stream.total_elevation_loss).to be_nil
    end
  end

  describe '#total_elevation_gain_s' do
    it 'returns formatted elevation gain' do
      stream = described_class.new('data' => [100.0, 105.3, 102.1, 110.7, 108.2])
      expect(stream.total_elevation_gain_s).to eq '13.9m'
    end

    it 'returns nil when data is nil' do
      stream = described_class.new(nil)
      expect(stream.total_elevation_gain_s).to be_nil
    end
  end

  describe '#total_elevation_loss_s' do
    it 'returns formatted elevation loss' do
      stream = described_class.new('data' => [100.0, 105.3, 102.1, 110.7, 108.2])
      expect(stream.total_elevation_loss_s).to eq '5.7m'
    end

    it 'returns nil when data is nil' do
      stream = described_class.new(nil)
      expect(stream.total_elevation_loss_s).to be_nil
    end
  end
end

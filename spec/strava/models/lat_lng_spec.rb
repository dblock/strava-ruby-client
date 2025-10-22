# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::LatLng do
  let(:latlng) { described_class.new([40.7128, -74.0060]) }

  describe '#initialize' do
    it 'sets the latlng array' do
      expect(latlng.to_a).to eq([40.7128, -74.0060])
    end

    it 'can be initialized with nil' do
      expect(described_class.new.to_a).to be_nil
    end
  end

  describe '#lat' do
    it 'returns the latitude' do
      expect(latlng.lat).to eq(40.7128)
    end
  end

  describe '#lng' do
    it 'returns the longitude' do
      expect(latlng.lng).to eq(-74.0060)
    end
  end

  describe '#lat=' do
    it 'sets the latitude' do
      latlng.lat = 34.0522
      expect(latlng.lat).to eq(34.0522)
      expect(latlng.lng).to eq(-74.0060)
    end

    it 'initializes array if nil' do
      new_latlng = described_class.new(nil)
      new_latlng.lat = 40.7128
      expect(new_latlng.lat).to eq(40.7128)
      expect(new_latlng.lng).to be_nil
    end
  end

  describe '#lng=' do
    it 'sets the longitude' do
      latlng.lng = -118.2437
      expect(latlng.lng).to eq(-118.2437)
      expect(latlng.lat).to eq(40.7128)
    end

    it 'initializes array if nil' do
      new_latlng = described_class.new(nil)
      new_latlng.lng = -74.0060
      expect(new_latlng.lng).to eq(-74.0060)
      expect(new_latlng.lat).to be_nil
    end
  end

  describe '#==' do
    context 'when comparing with another LatLng' do
      it 'returns true for identical LatLng objects' do
        expect(latlng == described_class.new([40.7128, -74.0060])).to be true
      end

      it 'returns false for different LatLng objects' do
        expect(latlng == described_class.new([34.0522, -118.2437])).to be false
      end
    end

    context 'when comparing with an array' do
      it 'returns true for identical array' do
        expect(latlng == [40.7128, -74.0060]).to be true
      end

      it 'returns false for different array' do
        expect(latlng == [34.0522, -118.2437]).to be false
      end

      it 'returns false for array with different length' do
        expect(latlng == [40.7128]).to be false
      end
    end

    context 'when comparing with other types' do
      it 'returns false for string' do
        expect(latlng == '40.7128,-74.0060').to be false
      end

      it 'returns false for number' do
        expect(latlng == 40.7128).to be false
      end

      it 'returns false for nil' do
        expect(latlng.nil?).to be false
      end
    end
  end

  describe '#to_a' do
    it 'returns the latlng array' do
      expect(latlng.to_a).to eq([40.7128, -74.0060])
    end
  end

  describe '#to_h' do
    it 'returns the latlng array' do
      expect(latlng.to_h).to eq([40.7128, -74.0060])
    end
  end

  describe '#json' do
    it 'returns the array JSON' do
      expect(latlng.as_json).to eq([40.7128, -74.0060])
      expect(latlng.to_json).to eq([40.7128, -74.0060].to_json)
    end
  end

  describe '#inspect' do
    it 'returns the array inspect' do
      expect(latlng.inspect).to eq([40.7128, -74.0060].inspect)
    end
  end

  describe 'to_s' do
    it 'returns the array to_s' do
      expect(latlng.to_s).to eq([40.7128, -74.0060].to_s)
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe Strava::Model do
  describe '.parse_time' do
    it 'parses UTC ISO 8601 timestamps' do
      time = described_class.parse_time('2018-02-20T18:02:13Z')
      expect(time).to eq Time.utc(2018, 2, 20, 18, 2, 13)
      expect(time).to be_utc
    end

    it 'parses ISO 8601 timestamps with an offset' do
      time = described_class.parse_time('2018-02-20T10:02:13+08:00')
      expect(time).to eq Time.utc(2018, 2, 20, 2, 2, 13)
      expect(time.utc_offset).to eq 8 * 60 * 60
    end

    it 'parses fractional seconds' do
      expect(described_class.parse_time('2018-02-20T18:02:13.5Z').usec).to eq 500_000
    end

    it 'falls back to Time.parse for other formats' do
      expect(described_class.parse_time('Tue, 20 Feb 2018 18:02:13 +0000')).to eq Time.utc(2018, 2, 20, 18, 2, 13)
    end

    it 'raises on invalid timestamps' do
      expect { described_class.parse_time('not a time') }.to raise_error ArgumentError
    end
  end
end

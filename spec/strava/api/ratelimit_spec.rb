# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Api::Ratelimit do
  let(:headers) { {} }
  let(:response) { double('response', headers: headers, body: nil) }
  let(:ratelimit) { described_class.new(response) }

  context 'without ratelimit headers' do
    it 'is not limited' do
      expect(ratelimit.limit?).to be false
    end

    it 'has nil fifteen_minutes' do
      expect(ratelimit.fifteen_minutes).to be_nil
    end

    it 'has nil total_day' do
      expect(ratelimit.total_day).to be_nil
    end

    it 'has nil fifteen_minutes_usage' do
      expect(ratelimit.fifteen_minutes_usage).to be_nil
    end

    it 'has nil total_day_usage' do
      expect(ratelimit.total_day_usage).to be_nil
    end

    it 'has nil fifteen_minutes_remaining' do
      expect(ratelimit.fifteen_minutes_remaining).to be_nil
    end

    it 'has nil total_day_remaining' do
      expect(ratelimit.total_day_remaining).to be_nil
    end

    it 'is not exceeded' do
      expect(ratelimit.exceeded?).to be false
      expect(ratelimit.exceeded).to be false
    end

    it 'returns an empty hash' do
      expect(ratelimit.to_h).to eq({})
    end

    it 'returns an empty string' do
      expect(ratelimit.to_s).to eq ''
    end
  end

  context 'with ratelimit headers under the limit' do
    let(:headers) { { 'x-ratelimit-limit' => '600,30000', 'x-ratelimit-usage' => '10,100' } }

    it 'is limited' do
      expect(ratelimit.limit?).to be true
    end

    it 'returns fifteen_minutes' do
      expect(ratelimit.fifteen_minutes).to eq 600
    end

    it 'returns total_day' do
      expect(ratelimit.total_day).to eq 30_000
    end

    it 'returns fifteen_minutes_usage' do
      expect(ratelimit.fifteen_minutes_usage).to eq 10
    end

    it 'returns total_day_usage' do
      expect(ratelimit.total_day_usage).to eq 100
    end

    it 'returns fifteen_minutes_remaining' do
      expect(ratelimit.fifteen_minutes_remaining).to eq 590
    end

    it 'returns total_day_remaining' do
      expect(ratelimit.total_day_remaining).to eq 29_900
    end

    it 'is not exceeded' do
      expect(ratelimit.exceeded?).to be false
      expect(ratelimit.exceeded).to be_nil
    end

    it 'returns a populated hash' do
      expect(ratelimit.to_h).to eq(
        limit: '600,30000',
        usage: '10,100',
        total_day: 30_000,
        total_day_usage: 100,
        total_day_remaining: 29_900,
        fifteen_minutes: 600,
        fifteen_minutes_usage: 10,
        fifteen_minutes_remaining: 590
      )
    end

    it 'returns a formatted string' do
      expect(ratelimit.to_s).to include('limit: 600,30000')
    end
  end

  context 'when the fifteen minute limit is exceeded' do
    let(:headers) { { 'x-ratelimit-limit' => '600,30000', 'x-ratelimit-usage' => '600,100' } }

    it 'is exceeded' do
      expect(ratelimit.exceeded?).to be true
      expect(ratelimit.exceeded).to eq(fifteen_minutes_remaining: 0)
    end
  end

  context 'when the total day limit is exceeded' do
    let(:headers) { { 'x-ratelimit-limit' => '600,30000', 'x-ratelimit-usage' => '10,30000' } }

    it 'is exceeded' do
      expect(ratelimit.exceeded?).to be true
      expect(ratelimit.exceeded).to eq(total_day_remaining: 0)
    end
  end
end

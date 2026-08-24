# frozen_string_literal: true

require 'spec_helper'

describe Strava::Models::Split do
  describe '#pace_per_kilometer_s' do
    it 'rounds seconds up to the next minute when seconds round to 60' do
      split = described_class.new('average_speed' => 0.463)
      expect(split.pace_per_kilometer_s).to eq '36m00s/km'
    end
  end
end

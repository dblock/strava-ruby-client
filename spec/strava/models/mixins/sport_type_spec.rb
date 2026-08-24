# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::DetailedActivity do
  describe '#sport_type_emoji' do
    {
      'AlpineSki' => '⛷️',
      'BackcountrySki' => '🎿️',
      'Golf' => '🏌️',
      'Hike' => '🥾',
      'IceSkate' => '⛸',
      'InlineSkate' => "\u{1F6FC}",
      'MountainBikeRide' => '🚵',
      'EMountainBikeRide' => '🚵',
      'Ride' => '🚴',
      'EBikeRide' => '🚴',
      'VirtualRide' => '🚴',
      'GravelRide' => '🚴',
      'RockClimbing' => '🧗',
      'Rowing' => '🚣',
      'Run' => '🏃',
      'VirtualRun' => '🏃',
      'TrailRun' => '🏃',
      'Sail' => '⛵️',
      'Skateboard' => '🛹',
      'Snowboard' => '🏂',
      'Soccer' => '⚽️',
      'Surfing' => '🏄',
      'Swim' => '🏊',
      'Walk' => '🚶',
      'WeightTraining' => '🏋️',
      'Wheelchair' => '♿',
      'Yoga' => '🧘'
    }.each do |sport_type, emoji|
      it "returns #{emoji.inspect} for #{sport_type}" do
        activity = described_class.new('sport_type' => sport_type)
        expect(activity.sport_type_emoji).to eq emoji
      end
    end

    it 'returns nil for an unknown sport type' do
      activity = described_class.new('sport_type' => 'SomethingElse')
      expect(activity.sport_type_emoji).to be_nil
    end
  end
end

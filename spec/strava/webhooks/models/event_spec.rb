# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Webhooks::Models::Event do
  let(:event_data) do
    {
      'aspect_type' => 'update',
      'event_time' => 1_516_126_040,
      'object_id' => 1_360_128_428,
      'object_type' => 'activity',
      'owner_id' => 134_815,
      'subscription_id' => 120_475,
      'updates' => {
        'title' => 'Messy'
      }
    }
  end

  let(:event) { described_class.new(event_data) }

  it 'parses event' do
    expect(event.id).to eq 1_360_128_428
    expect(event.aspect_type).to eq 'update'
    expect(event.event_time).to eq Time.at(1_516_126_040)
    expect(event.object_type).to eq 'activity'
    expect(event.owner_id).to eq 134_815
    expect(event.subscription_id).to eq 120_475
    expect(event.updates).to eq('title' => 'Messy')
  end
end

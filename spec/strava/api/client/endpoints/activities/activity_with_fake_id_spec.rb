# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity', vcr: { cassette_name: 'client/activity_with_fake_id' } do
  include_context 'API client'
  it 'returns activity' do
    activity = client.activity(id: 194_641_753_419_464_175_341_946_417_534)

    expect(activity).to be_a Strava::Models::Activity
    expect(activity.id).to eq 194_641_753_419_464_175_341_946_417_534

    map = activity.map
    expect(map).to be_a Strava::Models::Map
    expect(map.id).to eq 'a1946417534a1946417534a1946417534'
  end

  it 'returns activity by id' do
    activity = client.activity(194_641_753_419_464_175_341_946_417_534)
    expect(activity).to be_a Strava::Models::Activity
    expect(activity.id).to eq 194_641_753_419_464_175_341_946_417_534
  end
end

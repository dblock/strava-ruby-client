# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#gear', vcr: { cassette_name: 'client/gear' } do
  include_context 'API client'
  it 'returns gear' do
    gear = client.gear(id: 'b2338517')
    expect(gear).to be_a Strava::Models::Gear
    expect(gear.id).to eq 'b2338517'
    expect(gear.resource_state).to eq 3
    expect(gear.distance).to eq 54_349
    expect(gear.distance_in_miles_s).to eq '33.77mi'
    expect(gear.name).to eq 'Trek'
    expect(gear.primary).to be false
    expect(gear.brand_name).to eq 'Trek '
    expect(gear.model_name).to eq 'Madrone'
    expect(gear.description).to eq 'white'
    expect(gear.frame_type).to eq 3
    expect(gear.weight).to eq 9.1
    expect(gear.retired).to be false
  end
  it 'returns gear by id' do
    gear = client.gear('b2338517')
    expect(gear).to be_a Strava::Models::Gear
  end
end

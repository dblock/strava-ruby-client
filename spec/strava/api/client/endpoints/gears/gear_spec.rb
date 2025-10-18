# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#gear', vcr: { cassette_name: 'client/gear' } do
  include_context 'with API client'

  it 'returns running gear' do
    gear = client.gear(id: 'g3423618')
    expect(gear).to be_a Strava::Models::DetailedGear
    expect(gear.id).to eq 'g3423618'
    expect(gear.resource_state).to eq 3
    expect(gear.distance).to eq 966_309
    expect(gear.distance_in_miles_s).to eq '600.44mi'
    expect(gear.name).to eq 'Adidas Supernova ST'
    expect(gear.primary).to be false
    expect(gear.brand_name).to eq 'Adidas'
    expect(gear.model_name).to eq 'Supernova ST'
    expect(gear.description).to eq 'Marathon 2018.'
    expect(gear.retired).to be true
  end

  it 'returns bike gear' do
    gear = client.gear(id: 'b16988545')
    expect(gear).to be_a Strava::Models::DetailedGear
    expect(gear.id).to eq 'b16988545'
    expect(gear.resource_state).to eq 3
    expect(gear.distance).to eq 0
    expect(gear.distance_in_miles_s).to be_nil
    expect(gear.name).to eq 'Trek'
    expect(gear.primary).to be false
    expect(gear.brand_name).to eq 'Trek'
    expect(gear.model_name).to eq '450'
    expect(gear.description).to eq 'Favorite Trek.'
    expect(gear.frame_type).to eq 3
    expect(gear.weight).to eq 9.0
    expect(gear.retired).to be false
  end

  it 'returns gear by id' do
    gear = client.gear('g3423618')
    expect(gear).to be_a Strava::Models::DetailedGear
  end
end

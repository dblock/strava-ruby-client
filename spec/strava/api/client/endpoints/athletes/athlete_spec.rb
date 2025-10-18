# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete', vcr: { cassette_name: 'client/athlete' } do
  include_context 'with API client'
  it 'returns athlete' do
    athlete = client.athlete
    expect(athlete).to be_a Strava::Models::DetailedAthlete
    expect(athlete.id).to eq 26_462_176
    expect(athlete.created_at).to eq Time.parse('2017-11-28 19:05:35 UTC')
    expect(athlete.updated_at).to eq Time.parse('2025-09-27 12:57:32 UTC')
    expect(athlete.firstname).to eq 'Daniel'
    expect(athlete.lastname).to eq 'Doubrovkine'
    expect(athlete.city).to eq 'New York'
  end
end

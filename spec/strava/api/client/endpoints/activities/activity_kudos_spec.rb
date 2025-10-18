# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_kudos', vcr: { cassette_name: 'client/activity_kudos' } do
  include_context 'with API client'
  it 'returns activity kodoers' do
    activity_kudos = client.activity_kudos(id: 15_605_032_352)
    expect(activity_kudos).to be_a Enumerable
    expect(activity_kudos.count).to eq 2
    activity_kudoer = activity_kudos.first
    expect(activity_kudoer).to be_a Strava::Models::SummaryAthlete
  end

  it 'returns activity kodoers by id' do
    activity_kudos = client.activity_kudos(15_605_032_352)
    expect(activity_kudos).to be_a Enumerable
    expect(activity_kudos.count).to eq 2
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_kudos', vcr: { cassette_name: 'client/activity_kudos' } do
  include_context 'API client'
  it 'returns activity kodoers' do
    activity_kudos = client.activity_kudos(id: 3_958_491_750)
    expect(activity_kudos).to be_a Enumerable
    expect(activity_kudos.count).to eq 70
    activity_kudoer = activity_kudos.first
    expect(activity_kudoer).to be_a Strava::Models::Athlete
    expect(activity_kudoer.id).to eq nil # strava cuts it off due to user privacy
    expect(activity_kudoer.username).to be nil
  end
  it 'returns activity kodoers by id' do
    activity_kudos = client.activity_kudos(3_958_491_750)
    expect(activity_kudos).to be_a Enumerable
    expect(activity_kudos.count).to eq 70
  end
end

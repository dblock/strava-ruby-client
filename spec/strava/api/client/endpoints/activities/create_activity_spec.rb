# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#create_activity', vcr: { cassette_name: 'client/create_activity' } do
  include_context 'API client'
  it 'creates an activity' do
    activity = client.create_activity(
      name: 'strava-ruby-client activity',
      sport_type: 'Run',
      start_date_local: Time.now,
      elapsed_time: 1234,
      description: 'Test strava-ruby-client activity.',
      distance: 1000,
      photo_ids: nil,
      trainer: false,
      commute: false
    )
    expect(activity).to be_a Strava::Models::Activity
    expect(activity.name).to eq 'strava-ruby-client activity'
    expect(activity.description).to eq 'Test strava-ruby-client activity.'
    expect(activity.strava_url).to eq 'https://www.strava.com/activities/1982980795'
  end
end

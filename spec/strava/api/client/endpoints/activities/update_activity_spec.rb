# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#update_activity', vcr: { cassette_name: 'client/update_activity' } do
  include_context 'API client'
  it 'updates the activity' do
    activity = client.update_activity(
      id: 1_982_980_795,
      name: 'updated activity',
      description: 'Updated test strava-ruby-client activity.'
    )
    expect(activity).to be_a Strava::Models::Activity
    expect(activity.name).to eq 'updated activity'
    expect(activity.description).to eq 'Updated test strava-ruby-client activity.'
  end
  it 'updates the activity by id' do
    activity = client.update_activity(
      1_982_980_795,
      name: 'updated activity',
      description: 'Updated test strava-ruby-client activity.'
    )
    expect(activity).to be_a Strava::Models::Activity
    expect(activity.name).to eq 'updated activity'
    expect(activity.description).to eq 'Updated test strava-ruby-client activity.'
  end
end

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_kudos' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  let(:activity_kudos) { client.activity_kudos(id: 1_946_417_534) }
  it 'returns activity kodoers', vcr: { cassette_name: 'client/activity_kudos' } do
    expect(activity_kudos).to be_a Enumerable
    expect(activity_kudos.count).to eq 33
    activity_kudoer = activity_kudos.first
    expect(activity_kudoer).to be_a Strava::Models::Athlete
    expect(activity_kudoer.id).to eq 175_275
    expect(activity_kudoer.username).to eq 'fberselius'
  end
end

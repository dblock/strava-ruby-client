require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  let(:athlete) { client.athlete }
  it 'returns athlete', vcr: { cassette_name: 'client/athlete' } do
    expect(athlete).to be_a Strava::Models::Athlete
    expect(athlete.id).to eq 26_462_176
    expect(athlete.created_at).to eq Time.parse('2017-11-28 19:05:35 UTC')
    expect(athlete.updated_at).to eq Time.parse('2018-11-19 01:44:15 UTC')
    expect(athlete.firstname).to eq 'Daniel'
    expect(athlete.lastname).to eq 'Block'
    expect(athlete.city).to eq 'New York'
    expect(athlete.email).to eq 'dblock@example.com'
  end
end

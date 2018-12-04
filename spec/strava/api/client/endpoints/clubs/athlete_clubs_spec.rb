require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_clubs', vcr: { cassette_name: 'client/athlete_clubs' } do
  include_context 'API client'
  it 'returns athlete clubs' do
    athlete_clubs = client.athlete_clubs
    expect(athlete_clubs).to be_a Enumerable
    expect(athlete_clubs.count).to eq 6
    club = athlete_clubs.first
    expect(club.id).to eq 108_605
    expect(club.url).to eq 'nyrr'
    expect(club.strava_url).to eq 'https://www.strava.com/clubs/nyrr'
  end
end

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#athlete_clubs' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  describe '#athlete_clubs', vcr: { cassette_name: 'client/athlete_clubs' } do
    let(:athlete_clubs) { client.athlete_clubs }
    it 'returns athlete clubs' do
      expect(athlete_clubs).to be_a Enumerable
      expect(athlete_clubs.count).to eq 6
      club = athlete_clubs.first
      expect(club.id).to eq 108_605
      expect(club.url).to eq 'nyrr'
      expect(club.strava_url).to eq 'https://www.strava.com/clubs/nyrr'
    end
  end
end

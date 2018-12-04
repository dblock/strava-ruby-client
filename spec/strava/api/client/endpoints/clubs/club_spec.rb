require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club', vcr: { cassette_name: 'client/club' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns club' do
    club = client.club(id: 108_605)
    expect(club).to be_a Strava::Models::Club
    expect(club.id).to eq 108_605
    expect(club.url).to eq 'nyrr'
    expect(club.strava_url).to eq 'https://www.strava.com/clubs/nyrr'
  end
  it 'returns club by id' do
    club = client.club(108_605)
    expect(club).to be_a Strava::Models::Club
  end
end

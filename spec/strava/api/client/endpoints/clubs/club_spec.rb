require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns club', vcr: { cassette_name: 'client/club' } do
    club = client.club(id: 108_605)
    expect(club).to be_a Strava::Models::Club
    expect(club.id).to eq 108_605
    expect(club.url).to eq 'nyrr'
    expect(club.strava_url).to eq 'https://www.strava.com/clubs/nyrr'
  end
end

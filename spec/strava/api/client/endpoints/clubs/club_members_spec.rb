require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_members' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  describe '#club_members', vcr: { cassette_name: 'client/club_members' } do
    let(:club_members) { client.club_members(id: 108_605) }
    it 'returns club members' do
      expect(club_members).to be_a Enumerable
      expect(club_members.count).to eq 30
      member = club_members.first
      expect(member).to be_a Strava::Models::Athlete
      expect(member.name).to eq '   Davy-Michel  .'
    end
  end
end

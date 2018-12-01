require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_admins' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  describe '#club_admins', vcr: { cassette_name: 'client/club_admins' } do
    let(:club_admins) { client.club_admins(id: 108_605) }
    it 'returns club admins' do
      expect(club_admins).to be_a Enumerable
      expect(club_admins.count).to eq 5
      admin = club_admins.first
      expect(admin).to be_a Strava::Models::ClubAdmin
      expect(admin.name).to eq 'Rob S.'
    end
  end
end

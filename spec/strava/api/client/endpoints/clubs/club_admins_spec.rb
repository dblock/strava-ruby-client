require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_admins', vcr: { cassette_name: 'client/club_admins' } do
  include_context 'API client'
  it 'returns club admins' do
    club_admins = client.club_admins(id: 108_605)
    expect(club_admins).to be_a Enumerable
    expect(club_admins.count).to eq 5
    admin = club_admins.first
    expect(admin).to be_a Strava::Models::ClubAdmin
    expect(admin.name).to eq 'Rob S.'
  end
  it 'returns club admins by id' do
    club_admins = client.club_admins(108_605)
    expect(club_admins).to be_a Enumerable
    expect(club_admins.count).to eq 5
  end
end

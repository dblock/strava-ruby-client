require 'spec_helper'

RSpec.describe 'Strava::Api::Client#club_members', vcr: { cassette_name: 'client/club_members' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns club members' do
    club_members = client.club_members(id: 108_605)
    expect(club_members).to be_a Enumerable
    expect(club_members.count).to eq 30
    member = club_members.first
    expect(member).to be_a Strava::Models::ClubMember
    expect(member.firstname).to eq '   Davy-Michel'
  end
  it 'returns club members by id' do
    club_members = client.club_members(108_605)
    expect(club_members).to be_a Enumerable
    expect(club_members.count).to eq 30
  end
end

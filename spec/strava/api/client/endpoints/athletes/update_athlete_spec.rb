require 'spec_helper'

RSpec.describe 'Strava::Api::Client#update_athlete' do
  include_context 'API client'
  it 'updates and returns athlete', vcr: { cassette_name: 'client/update_athlete' } do
    athlete = client.update_athlete(weight: 90.1)
    expect(athlete).to be_a Strava::Models::Athlete
    expect(athlete.id).to eq 29_323_238
    expect(athlete.weight).to eq 90.1
    clubs = athlete.clubs
    expect(clubs).to be_a Enumerable
    club = clubs.first
    expect(club).to be_a Strava::Models::Club
    expect(club.name).to eq 'NYRR Open Run'
    shoes = athlete.shoes
    expect(shoes).to be_a Enumerable
    shoe = shoes.first
    expect(shoe).to be_a Strava::Models::Gear
    expect(shoe.name).to eq 'adidas Supernova'
    bikes = athlete.bikes
    expect(bikes).to be_a Enumerable
    bike = bikes.first
    expect(bike).to be_a Strava::Models::Gear
    expect(bike.name).to eq 'Émonda SLR 9 Disc'
  end
end

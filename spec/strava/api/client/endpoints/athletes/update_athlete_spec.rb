# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#update_athlete' do
  include_context 'with API client'
  it 'updates and returns athlete', vcr: { cassette_name: 'client/update_athlete' } do
    athlete = client.update_athlete(weight: 90.1)
    expect(athlete).to be_a Strava::Models::DetailedAthlete
    expect(athlete.id).to eq 26_462_176
    expect(athlete.weight).to eq 90.1
    clubs = athlete.clubs
    expect(clubs).to be_a Enumerable
    club = clubs.first
    expect(club).to be_a Strava::Models::SummaryClub
    expect(club.name).to eq 'New York Road Runners'
    expect(club.strava_url).to eq 'https://www.strava.com/clubs/nyrr'
    shoes = athlete.shoes
    expect(shoes).to be_a Enumerable
    shoe = shoes.first
    expect(shoe).to be_a Strava::Models::SummaryGear
    expect(shoe.name).to eq 'Adidas Ultraboost 5X'
    bikes = athlete.bikes
    expect(bikes).to eq([])
  end
end

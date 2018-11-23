require 'spec_helper'

RSpec.describe Strava::Api::Client do
  before do
    Strava::Api::Config.reset
  end
  it_behaves_like 'web client'
  context 'with a token' do
    let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
    describe '#athlete', vcr: { cassette_name: 'client_athlete' } do
      let(:athlete) { client.athlete }
      it 'returns athlete' do
        expect(athlete).to be_a Strava::Models::Athlete
        expect(athlete.id).to eq 26_462_176
        expect(athlete.created_at).to eq Time.parse('2017-11-28 19:05:35 UTC')
        expect(athlete.updated_at).to eq Time.parse('2018-11-19 01:44:15 UTC')
        expect(athlete.firstname).to eq 'Daniel'
        expect(athlete.lastname).to eq 'Block'
        expect(athlete.city).to eq 'New York'
        expect(athlete.email).to eq 'dblock@example.com'
      end
    end
    describe '#athlete_activities', vcr: { cassette_name: 'client_athlete_activities' } do
      let(:athlete_activities) { client.athlete_activities }
      it 'returns athlete activities' do
        expect(athlete_activities).to be_a Enumerable
        expect(athlete_activities.count).to eq 30
        activity = athlete_activities.first
        expect(activity.id).to eq 1_972_463_847
        expect(activity.athlete).to be_a Strava::Models::Athlete
        expect(activity.map).to be_a Strava::Models::Map
        expect(activity.start_date).to be_a Time
      end
    end
  end
end

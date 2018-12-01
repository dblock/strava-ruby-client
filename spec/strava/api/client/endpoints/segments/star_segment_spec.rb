require 'spec_helper'

RSpec.describe 'Strava::Api::Client#star_segment' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  #   it 'stars a segment', vcr: { cassette_name: 'client/star_segment' } do
  #     segment = client.star_segment(id: 50272077110, starred: true)
  #     expect(segment.resource_state).to eq 3
  #     expect(segment.name).to eq 'E 14th St Climb'
  #     expect(segment.starred).to be true
  #   end
end

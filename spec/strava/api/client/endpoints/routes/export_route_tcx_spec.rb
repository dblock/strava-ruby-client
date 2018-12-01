require 'spec_helper'

RSpec.describe 'Strava::Api::Client#export_route_tcx' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'exports a route file', vcr: { cassette_name: 'client/export_route_tcx' } do
    route = client.export_route_tcx(id: 16_341_573)
    expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"

    xml = MultiXml.parse(route)
    expect(xml).to be_a Hash
  end
end

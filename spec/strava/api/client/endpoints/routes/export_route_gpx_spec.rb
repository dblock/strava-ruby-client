require 'spec_helper'

RSpec.describe 'Strava::Api::Client#export_route_gpx' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'exports a route file', vcr: { cassette_name: 'client/export_route_gpx' } do
    route = client.export_route_gpx(id: 16_341_573)
    expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<gpx creator=\"StravaGPX\""

    xml = MultiXml.parse(route)
    expect(xml).to be_a Hash

    gpx_file = GPX::GPXFile.new(gpx_data: route)
    expect(gpx_file).to be_a GPX::GPXFile
    expect(gpx_file.name).to eq 'Lower Manhattan Loop'
    expect(gpx_file.description).to eq 'My usual long run when I am too lazy to go to Central Park.'
  end
end

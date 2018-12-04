require 'spec_helper'

RSpec.describe 'Strava::Api::Client#export_route_tcx', vcr: { cassette_name: 'client/export_route_tcx' } do
  include_context 'API client'
  it 'exports a route file' do
    route = client.export_route_tcx(id: 16_341_573)
    expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"

    xml = MultiXml.parse(route)
    expect(xml).to be_a Hash
  end
  it 'exports a route file by id' do
    route = client.export_route_tcx(16_341_573)
    expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"
  end
end

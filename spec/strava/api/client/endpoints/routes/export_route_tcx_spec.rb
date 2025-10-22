# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#export_route_tcx', vcr: { cassette_name: 'client/export_route_tcx' } do
  include_context 'with API client'

  context 'an exported route' do
    let(:route) { client.export_route_tcx(id: 16_341_573) }

    it 'is a TrainingCenterDatabase' do
      expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"
    end

    context 'as xml' do
      let(:xml) { MultiXml.parse(route) }

      it 'is valid XML' do
        expect(xml).to be_a Hash
      end
    end

    context 'as parsed tcx' do
      let(:tcx) do
        Tempfile.open(['route', '.tcx']) do |temp_file|
          temp_file.write(route)
          temp_file.close

          TCXRead.new(temp_file.path)
        end
      end

      it 'is valid' do
        expect(tcx).to be_a(TCXRead)
        expect(tcx.total_distance_meters).to eq 0
        expect(tcx.total_time_seconds).to eq 0
      end
    end
  end

  it 'exports a route file by id' do
    route = client.export_route_tcx(16_341_573)
    expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"
  end
end

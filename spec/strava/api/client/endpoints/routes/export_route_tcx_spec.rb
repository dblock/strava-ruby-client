# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#export_route_tcx', vcr: { cassette_name: 'client/export_route_tcx' } do
  include_context 'with API client'

  describe 'an exported route' do
    let(:route) { client.export_route_tcx(id: 16_341_573) }

    it 'is a TrainingCenterDatabase' do
      expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"
    end

    describe 'as xml' do
      let(:xml) { MultiXml.parse(route) }

      it 'is valid XML' do
        expect(xml).to be_a Hash
      end
    end

    describe 'as parsed tcx' do
      let(:tcx) { Tcx.load(route) }

      it 'is valid' do
        expect(tcx).to be_a(Tcx::Database)
        expect(tcx.courses.count).to eq 1
        expect(tcx.courses.first.name).to eq 'Lower Manhattan'
      end
    end
  end

  it 'exports a route file by id' do
    route = client.export_route_tcx(16_341_573)
    expect(route).to start_with "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<TrainingCenterDatabase"
  end
end

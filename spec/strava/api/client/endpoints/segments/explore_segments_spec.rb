# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#explore_segments' do
  include_context 'API client'
  it 'returns segments matching a query', vcr: { cassette_name: 'client/explore_segments' } do
    segments = client.explore_segments(bounds: [36.372975, -94.220234, 36.415949, -94.183670], activity_type: 'running')
    expect(segments).to be_a Enumerable
    segment = segments.first
    expect(segment.id).to eq 5_699_008
    expect(segment.resource_state).to eq 2
    expect(segment.name).to eq 'Compton Gardens hill'
    expect(segment.climb_category).to eq 0
    expect(segment.climb_category_desc).to eq 'NC'
    expect(segment.avg_grade).to eq 4.6
    expect(segment.start_latlng).to eq [36.377702, -94.207242]
    expect(segment.end_latlng).to eq [36.375948, -94.207689]
    expect(segment.elev_difference).to eq 9.6
    expect(segment.points).to eq 's_`}Ehz~}PRFv@P`@Bj@Xd@Fh@PVFhAHLCDG' # TODO: polyline
    expect(segment.starred).to be false
  end
end

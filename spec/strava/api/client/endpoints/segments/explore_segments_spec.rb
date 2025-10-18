# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#explore_segments' do
  include_context 'with API client'
  it 'returns segments matching a query', vcr: { cassette_name: 'client/explore_segments' } do
    segments = client.explore_segments(bounds: [36.372975, -94.220234, 36.415949, -94.183670], activity_type: 'running')
    expect(segments).to be_a Enumerable
    segment = segments.first
    expect(segment.id).to eq 8_794_067
    expect(segment.resource_state).to eq 2
    expect(segment.name).to eq 'The Full Crystal Bridges Hill Segment'
    expect(segment.climb_category).to eq 0
    expect(segment.climb_category_desc).to eq 'NC'
    expect(segment.avg_grade).to eq 4.8
    expect(segment.start_latlng).to eq [36.385755, -94.203054]
    expect(segment.end_latlng).to eq [36.383246, -94.204826]
    expect(segment.elev_difference).to eq 18.6
    expect(segment.points).to eq '}qa}Eb`~}Pp@FdA^RJt@nARPVHb@Bb@JFLALS^?`@THv@OT?VLNR\\x@FFL?LI' # TODO: polyline
    expect(segment.starred).to be false
  end
end

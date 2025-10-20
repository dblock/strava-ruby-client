# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#segment', vcr: { cassette_name: 'client/segment' } do
  include_context 'with API client'
  it 'returns a segment' do
    segment = client.segment(id: 1_109_718)
    expect(segment.resource_state).to eq 3
    expect(segment.name).to eq 'E 14th St Climb'
    expect(segment.maximum_grade).to eq(-0.6)
    expect(segment.elevation_high).to eq 7.1
    expect(segment.elevation_low).to eq 3.8
    expect(segment.activity_type).to eq 'Run'
    expect(segment.average_grade).to eq(-0.8)
    expect(segment.climb_category).to eq 0
    expect(segment.city).to eq 'New York'
    expect(segment.state).to eq 'NY'
    expect(segment.country).to eq 'United States'
    expect(segment.start_latlng).to eq [40.73554842732847, -73.98271151818335]
    expect(segment.end_latlng).to eq [40.73427177965641, -73.97865023463964]
    expect(segment.private).to be false
    expect(segment.hazardous).to be false
    expect(segment.starred).to be true
    expect(segment.created_at).to be_a Time
    expect(segment.updated_at).to be_a Time
    expect(segment.map).to be_a Strava::Models::Map
    expect(segment.effort_count).to eq 3964
    expect(segment.athlete_count).to eq 1144
    expect(segment.star_count).to eq 3
    expect(segment.athlete_segment_stats).to be_a Strava::Models::SummarySegmentEffort
    expect(segment.xoms).to be_a Strava::Models::Xoms
    expect(segment.xoms.kom).to eq '1:09'
    expect(segment.xoms.qom).to eq '1:31'
    expect(segment.xoms.overall).to eq '1:09'
    expect(segment.xoms.destination).to be_a Strava::Models::Destination
    expect(segment.xoms.destination.name).to eq 'All-Time'
    expect(segment.xoms.destination.href).to eq 'strava://segments/1109718/leaderboard'
    expect(segment.local_legend).to be_a Strava::Models::LocalLegend
    expect(segment.local_legend.athlete_id).to eq 149_514_149
  end

  it 'returns a segment by id' do
    segment = client.segment(1_109_718)
    expect(segment.resource_state).to eq 3
    expect(segment.name).to eq 'E 14th St Climb'
  end
end

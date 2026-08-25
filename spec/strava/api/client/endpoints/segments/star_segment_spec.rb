# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#star_segment', vcr: { cassette_name: 'client/star_segment' } do
  include_context 'with API client'
  it 'stars a segment' do
    segment = client.star_segment(id: 1_109_718, starred: true)
    expect(segment).to be_a Strava::Models::DetailedSegment
    expect(segment.starred).to be true
  end

  it 'stars a segment by id' do
    segment = client.star_segment(1_109_718, starred: true)
    expect(segment).to be_a Strava::Models::DetailedSegment
    expect(segment.starred).to be true
  end

  it 'raises an error when :starred is missing' do
    expect { client.star_segment(id: 1_109_718) }.to raise_error ArgumentError, 'Required argument :starred missing'
  end
end

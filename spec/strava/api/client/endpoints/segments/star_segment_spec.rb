# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#star_segment' do
  include_context 'API client'
  #   it 'stars a segment', vcr: { cassette_name: 'client/star_segment' } do
  #     segment = client.star_segment(id: 50272077110, starred: true)
  #     expect(segment.resource_state).to eq 3
  #     expect(segment.name).to eq 'E 14th St Climb'
  #     expect(segment.starred).to be true
  #   end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::DetailedAthlete do
  let(:fixtures) { 'spec/fixtures/strava/models' }
  let(:json) { JSON.parse(File.read("#{fixtures}/detailed_athlete.json")) }
  let(:activity) { described_class.new(json) }

  describe 'ride' do
    it 'exposes custom properties' do
      expect(activity.strava_url).to eq 'https://www.strava.com/athletes/dblockdotorg'
      expect(activity.name).to eq 'Daniel Doubrovkine'
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::Athlete do
  let(:fixtures) { 'spec/fixtures/strava/models' }
  let(:json) { JSON.parse(File.read("#{fixtures}/athlete.json")) }
  let(:activity) { Strava::Models::Athlete.new(json) }
  describe 'ride' do
    it 'exposes custom properties' do
      expect(activity.strava_url).to eq 'https://www.strava.com/athletes/dblockdotorg'
      expect(activity.name).to eq 'Daniel Block'
    end
  end
end

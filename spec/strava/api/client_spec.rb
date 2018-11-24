require 'spec_helper'

RSpec.describe Strava::Api::Client do
  before do
    Strava::Api::Config.reset
  end
  it_behaves_like 'web client'
end

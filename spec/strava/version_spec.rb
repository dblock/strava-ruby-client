# frozen_string_literal: true

require 'spec_helper'

describe 'Version' do
  it 'has a version' do
    expect(Strava::VERSION).not_to be_nil
  end
end

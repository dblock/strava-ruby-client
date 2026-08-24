# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#revoke', vcr: { cassette_name: 'client/revoke' } do
  include_context 'with API client'
  it 'revokes authorization' do
    authorization = client.revoke
    expect(authorization).to be_a Strava::Models::Authorization
    expect(authorization.access_token).to eq 'access-token'
  end
end

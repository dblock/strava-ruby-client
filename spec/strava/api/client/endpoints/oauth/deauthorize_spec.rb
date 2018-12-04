require 'spec_helper'

RSpec.describe 'Strava::Api::Client#deauthorize', vcr: { cassette_name: 'client/deauthorize' } do
  include_context 'API client'
  it 'revokes authorization' do
    authorization = client.deauthorize
    expect(authorization).to be_a Strava::Models::Authorization
    expect(authorization.access_token).to eq 'access-token'
  end
end

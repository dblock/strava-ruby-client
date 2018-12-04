require 'spec_helper'

RSpec.describe 'Strava::Api::Client#deauthorize', vcr: { cassette_name: 'client/deauthorize' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'revokes authorization' do
    authorization = client.deauthorize
    expect(authorization).to be_a Strava::Models::Authorization
    expect(authorization.access_token).to eq 'access-token'
  end
end

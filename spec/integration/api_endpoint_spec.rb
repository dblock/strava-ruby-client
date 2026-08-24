# frozen_string_literal: true

require 'spec_helper'
require 'net/http'

#
# Verifies that Strava's real API base URL is reachable and responds as
# expected. This is a live network test (no VCR/WebMock) intended to catch
# regressions where the configured `endpoint` no longer points at Strava's
# actual API, e.g. https://github.com/dblock/strava-ruby-client/issues/54.
#
# @see Strava::Api::Config
#
RSpec.describe 'Strava API endpoint', :integration do
  it 'is reachable' do
    uri = URI(Strava::Api::Config.endpoint)
    response = Net::HTTP.get_response(uri)

    # Requesting the base URL with no path should return a real response
    # from Strava, not fail to connect, which would indicate the
    # configured endpoint doesn't actually exist.
    expect(response.code).to eq '404'
    expect(JSON.parse(response.body)).to eq(
      'message' => 'Record Not Found',
      'errors' => [
        { 'resource' => 'resource', 'field' => 'path', 'code' => 'invalid' }
      ]
    )
  end
end

# frozen_string_literal: true

RSpec.shared_context 'API client', shared_context: :metadata do
  before do
    Strava::Api::Config.reset
  end
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
end

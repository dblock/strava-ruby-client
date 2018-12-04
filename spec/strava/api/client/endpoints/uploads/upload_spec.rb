require 'spec_helper'

RSpec.describe 'Strava::Api::Client#get_upload', vcr: { cassette_name: 'client/upload' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns a finished upload' do
    upload = client.upload(id: 2_136_460_097)
    expect(upload.id).to eq 2_136_460_097
    expect(upload.external_id).to eq 'strava-ruby-client-upload-1.tcx'
    expect(upload.error).to eq nil
    expect(upload.status).to eq 'Your activity is ready.'
    expect(upload.activity_id).to eq 1_998_557_443
  end
  it 'returns a finished upload by id' do
    upload = client.upload(2_136_460_097)
    expect(upload.id).to eq 2_136_460_097
  end
end

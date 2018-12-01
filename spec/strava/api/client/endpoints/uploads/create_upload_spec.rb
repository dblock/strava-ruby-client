require 'spec_helper'

RSpec.describe 'Strava::Api::Client#upload_activity' do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  let(:file) { 'spec/fixtures/strava/files/17611540601.tcx' }
  it 'uploads an activity', vcr: { cassette_name: 'client/create_upload' } do
    upload = client.create_upload(
      file: Faraday::UploadIO.new(file, 'application/tcx+xml'),
      name: 'Uploaded Activity',
      description: 'Uploaded by strava-ruby-client.',
      data_type: 'tcx',
      external_id: 'strava-ruby-client-upload-1'
    )
    expect(upload.id).to eq 2_136_460_097
    expect(upload.external_id).to eq 'strava-ruby-client-upload-1.tcx'
    expect(upload.error).to eq nil
    expect(upload.status).to eq 'Your activity is still being processed.'
    expect(upload.activity_id).to eq nil
  end
end

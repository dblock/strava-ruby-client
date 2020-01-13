require 'spec_helper'

RSpec.describe 'Strava::Api::Client#upload_activity' do
  include_context 'API client'
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
  it 'returns a Strava::Errors::UploadFailed on upload error', vcr: :all do
    expect do
      client.create_upload(
        file: Faraday::UploadIO.new(file, 'application/tcx+xml'),
        data_type: 'tcx'
      )
    end.to raise_error(Strava::Errors::UploadFailed) do |error| # rubocop:disable Style/MultilineBlockChain
      expect(error.upload.activity_id).to eq(nil)
      expect(error.upload.error).to eq('17611540601.tcx duplicate of activity 3008913003')
      expect(error.upload.external_id).to eq('17611540601.tcx')
      expect(error.upload.id).to eq(3208301231) # rubocop:disable Style/NumericLiterals
      expect(error.upload.status).to eq('There was an error processing your activity.')
    end
  end
end

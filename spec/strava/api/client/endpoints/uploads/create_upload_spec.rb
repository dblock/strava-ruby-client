# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#upload_activity' do
  include_context 'API client'
  let(:file) { 'spec/fixtures/strava/files/17611540601.tcx' }
  it 'uploads an activity successfully', vcr: { cassette_name: 'client/create_upload' } do
    upload = client.create_upload(
      file: Faraday::UploadIO.new(file, 'application/tcx+xml'),
      name: 'Uploaded Activity',
      description: 'Uploaded by strava-ruby-client.',
      data_type: 'tcx'
    )

    expect(upload.id).to be_a(Integer)
    expect(upload.error).to be(nil)
    expect(upload.status).to eq('Your activity is still being processed.')
    expect(upload.activity_id).to eq(nil)

    # strava needs some time, to process the uploaded file, loop until processing finished
    upload_status = client.upload(upload.id)
    while upload_status.processing?
      sleep 1
      upload_status = client.upload(upload.id)
    end

    expect(upload_status).to be_a(Strava::Models::Upload)
    expect(upload_status.id).to be_a(Integer)
    expect(upload_status.id).to eql(upload.id)
    expect(upload_status.processed?).to be(true)
    expect(upload_status.processing?).to be(false)
    expect(upload_status.external_id).to eql('17611540601.tcx')
    expect(upload_status.activity_id).to be_a(Integer)
  end

  it 'uploads a file and checks immediately, leaving no time to process the file', vcr: { cassette_name: 'client/create_upload_file_processing' } do
    upload = client.create_upload(file: Faraday::UploadIO.new(file, 'application/tcx+xml'), data_type: 'tcx')
    upload_status = client.upload(upload.id)

    expect(upload_status).to be_a(Strava::Models::Upload)
    expect(upload_status.status).to eql('Your activity is still being processed.')
    expect(upload_status.id).to be_a(Integer)
    expect(upload_status.external_id).to be(nil)
    expect(upload_status.error).to be(nil)
    expect(upload_status.processing?).to be(true)
    expect(upload_status.processed?).to be(false)
  end

  it 'uploads a duplicate, that causes a Strava::Errors::UploadError to be raised', vcr: { cassette_name: 'client/create_upload_file_with_error' } do
    upload = client.create_upload(file: Faraday::UploadIO.new(file, 'application/tcx+xml'), data_type: 'tcx')
    expect do
      upload_status = client.upload(upload.id)
      while upload_status.processing?
        sleep 1
        upload_status = client.upload(upload.id)
      end
    end.to raise_error(Strava::Errors::UploadError) do |upload_error|
      expect(upload_error.status).to be(200)
      expect(upload_error.message).to eq('17611540601.tcx duplicate of activity 8319193780')
      expect(upload_error.error_status).to eq('There was an error processing your activity.')
      expect(upload_error.headers).to be_a(Hash)

      expect(upload_error.upload).to be_a(Strava::Models::Upload)
      expect(upload_error.upload.id).to be_a(Integer)
      expect(upload_error.upload.error).to eql('17611540601.tcx duplicate of activity 8319193780')
      expect(upload_error.upload.status).to eql('There was an error processing your activity.')
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_photos', vcr: { cassette_name: 'client/activity_photos' } do
  include_context 'with API client'

  context 'with activity photos' do
    let(:activity_photos) { client.activity_photos(id: 16_181_809_559) }

    it 'returns activity photos' do
      expect(activity_photos).to be_a Enumerable
      expect(activity_photos.count).to eq 4
    end

    context 'when photo' do
      let(:activity_photo) { activity_photos.first }

      it 'returns all fields' do
        expect(activity_photo.unique_id).to eq '6D1E4A0B-0A46-406A-874A-C3ED694DDE55'
        expect(activity_photo.urls).to eq('5000' => 'https://dgtzuqphqg23d.cloudfront.net/gskSZVRgkpQ-O9HOdMXpYLEfDvRkZBNs_hGKBKbsmds-1536x2048.jpg')
        expect(activity_photo.source).to eq 1
        expect(activity_photo.status).to eq 3
        expect(activity_photo.cursor).to be_nil
        expect(activity_photo.athlete_id).to eq 26_462_176
        expect(activity_photo.activity_id).to eq 16_181_809_559
        expect(activity_photo.activity_name).to eq 'Run with Artyom'
        expect(activity_photo.resource_state).to eq 2
        expect(activity_photo.caption).to eq ''
        expect(activity_photo.created_at).to be_a Time
        expect(activity_photo.created_at_local).to be_a Time
        expect(activity_photo.uploaded_at).to be_a Time
        expect(activity_photo.sizes).to eq('5000' => [1536, 2048])
        expect(activity_photo.default_photo).to be true
      end
    end

    context 'when video' do
      let(:activity_video) { activity_photos[3] }

      it 'returns all fields' do
        expect(activity_video.unique_id).to eq '077BE6E7-DDA8-4F38-BB4A-DF0F4640C2D5'
        expect(activity_video.urls).to eq('5000' => 'https://d35tn3x5zm6xrc.cloudfront.net/LEpTlUieI8wxuKwsdTd_CAHz0i2BccppnSXEfVV5_p4/thumbnails/LEpTlUieI8wxuKwsdTd_CAHz0i2BccppnSXEfVV5_p4_1080x1920.jpg')
        expect(activity_video.source).to eq 1
        expect(activity_video.status).to eq 3
        expect(activity_video.cursor).to be_nil
        expect(activity_video.athlete_id).to eq 26_462_176
        expect(activity_video.activity_id).to eq 16_181_809_559
        expect(activity_video.activity_name).to eq 'Run with Artyom'
        expect(activity_video.resource_state).to eq 2
        expect(activity_video.caption).to eq ''
        expect(activity_video.created_at).to be_a Time
        expect(activity_video.created_at_local).to be_a Time
        expect(activity_video.uploaded_at).to be_a Time
        expect(activity_video.sizes).to eq('5000' => [1080, 1920])
        expect(activity_video.default_photo).to be false
        expect(activity_video.video_url).to eq 'https://d35tn3x5zm6xrc.cloudfront.net/LEpTlUieI8wxuKwsdTd_CAHz0i2BccppnSXEfVV5_p4/hls/LEpTlUieI8wxuKwsdTd_CAHz0i2BccppnSXEfVV5_p4.m3u8'
        expect(activity_video.duration).to eq 4
        expect(activity_video.location).to eq([40.7557, -73.9966])
      end
    end
  end

  it 'returns activity photos by id' do
    activity_photos = client.activity_photos(16_181_809_559)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 4
  end
end

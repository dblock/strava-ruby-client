# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_photos', vcr: { cassette_name: 'client/activity_photos' } do
  include_context 'API client'
  it 'returns activity photos' do
    activity_photos = client.activity_photos(id: 3_958_491_750)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 1
    activity_photo = activity_photos.first
    expect(activity_photo.id).to eq nil
    expect(activity_photo.unique_id).to eq 'F775717B-D1C1-443A-AD99-3D9A80FF11C9'
    expect(activity_photo.urls).to eq('1800' => 'https://d3nn82uaxijpm6.cloudfront.net/assets/media/placeholder-photo@4x-13b0b44cfa828acc8b95d8dc4b8157d87666aa1ea8ef814c6ec36cd542d2b756.png')
    expect(activity_photo.source).to eq 1
    expect(activity_photo.athlete_id).to eq 24_776_507
    expect(activity_photo.activity_id).to eq 3_958_491_750
    expect(activity_photo.activity_name).to eq 'Bitche, please 🥳'
    expect(activity_photo.resource_state).to eq 2
    expect(activity_photo.caption).to eq ''
    expect(activity_photo.created_at).to be_a Time
    expect(activity_photo.created_at_local).to be_a Time
    expect(activity_photo.uploaded_at).to be_a Time
    expect(activity_photo.sizes).to eq('1800' => [1372, 1000])
    expect(activity_photo.default_photo).to be true
  end
  it 'returns activity photos by id' do
    activity_photos = client.activity_photos(3_958_491_750)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 1
  end
end

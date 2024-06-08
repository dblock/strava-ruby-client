# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_photos', vcr: { cassette_name: 'client/activity_photos' } do
  include_context 'API client'
  it 'returns activity photos' do
    activity_photos = client.activity_photos(id: 7_287_327_028)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 2
    activity_photo = activity_photos.first
    expect(activity_photo.id).to eq nil
    expect(activity_photo.unique_id).to eq 'f5ebd6e7-8c87-4478-86ce-ce5cf31cf519'
    expect(activity_photo.urls).to eq('5000' => 'https://dgtzuqphqg23d.cloudfront.net/3wt2DyGHKHX6gJSXzpAcVdEI1QE2luP9xoDLD0CX2w4-2048x1536.jpg')
    expect(activity_photo.source).to eq 1
    expect(activity_photo.athlete_id).to eq 24_776_507
    expect(activity_photo.activity_id).to eq 7_287_327_028
    expect(activity_photo.activity_name).to eq 'Die Rückkehr der Cornichons! 🥒'
    expect(activity_photo.resource_state).to eq 2
    expect(activity_photo.caption).to eq ''
    expect(activity_photo.created_at).to be_a Time
    expect(activity_photo.created_at_local).to be_a Time
    expect(activity_photo.uploaded_at).to be_a Time
    expect(activity_photo.sizes).to eq('5000' => [2048, 1536])
    expect(activity_photo.default_photo).to be true
  end
  it 'returns activity photos by id' do
    activity_photos = client.activity_photos(3_958_491_750)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 1
  end
end

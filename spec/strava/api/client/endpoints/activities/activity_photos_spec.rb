# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_photos', vcr: { cassette_name: 'client/activity_photos' } do
  include_context 'API client'
  it 'returns activity photos' do
    activity_photos = client.activity_photos(id: 1_946_417_534)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 9
    activity_photo = activity_photos.first
    expect(activity_photo.id).to eq nil
    expect(activity_photo.unique_id).to eq '65889142-538D-4EE5-96F5-3DC3B773B1E3'
    expect(activity_photo.urls).to eq('0' => 'https://dgtzuqphqg23d.cloudfront.net/eb4DMJ2hJW3k_g9URZEMfaJ8rZfHagrNlZRuEZz0osU-29x64.jpg')
    expect(activity_photo.source).to eq 1
    expect(activity_photo.athlete_id).to eq 26_462_176
    expect(activity_photo.activity_id).to eq 1_946_417_534
    expect(activity_photo.activity_name).to eq 'TCS NYC Marathon 2018'
    expect(activity_photo.resource_state).to eq 2
    expect(activity_photo.caption).to eq ''
    expect(activity_photo.created_at).to be_a Time
    expect(activity_photo.created_at_local).to be_a Time
    expect(activity_photo.uploaded_at).to be_a Time
    expect(activity_photo.sizes).to eq('0' => [29, 64])
    expect(activity_photo.default_photo).to be false
  end
  it 'returns activity photos by id' do
    activity_photos = client.activity_photos(1_946_417_534)
    expect(activity_photos).to be_a Enumerable
    expect(activity_photos.count).to eq 9
  end
end

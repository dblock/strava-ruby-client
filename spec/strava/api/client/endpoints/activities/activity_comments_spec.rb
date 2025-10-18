# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_comments', vcr: { cassette_name: 'client/activity_comments' } do
  include_context 'with API client'

  let(:activity_comments) do
    client.activity_comments(id: 15_605_032_352)
  end

  let(:first_activity_comment) do
    activity_comments.first
  end

  it 'returns activity comments' do
    expect(activity_comments).to be_a Enumerable
    expect(activity_comments.count).to eq 3
    activity_comment = activity_comments.first
    expect(activity_comment.id).to eq 2_257_523_290
    expect(activity_comment.activity_id).to eq 15_605_032_352
    expect(activity_comment.resource_state).to eq 2
    expect(activity_comment.text).to eq 'you pass?'
    expect(activity_comment.created_at).to eq Time.parse('2025-08-27 18:36:59 UTC')
    athlete = activity_comment.athlete
    expect(athlete).to be_a Strava::Models::SummaryAthlete
    expect(athlete.resource_state).to eq 2
    expect(athlete.firstname).to eq 'Sasha'
    expect(athlete.lastname).to eq 'C.'
  end

  it 'returns activity comments by id' do
    expect(activity_comments).to be_a Enumerable
    expect(activity_comments.count).to eq 3
  end

  it 'returns ratelimits with paginated comments' do
    expect(activity_comments.http_response).to be_a Strava::Web::ApiResponse
    expect(activity_comments.http_response.ratelimit).to be_a Strava::Api::Ratelimit
    expect(activity_comments.http_response.ratelimit.fifteen_minutes).to eq 200
    expect(activity_comments.http_response.ratelimit.fifteen_minutes_usage).to eq 1
  end

  it 'returns ratelimits with each comment' do
    expect(first_activity_comment.http_response).to be_a Strava::Web::ApiResponse
    expect(first_activity_comment.http_response.ratelimit).to be_a Strava::Api::Ratelimit
    expect(first_activity_comment.http_response.ratelimit.fifteen_minutes).to eq 200
    expect(first_activity_comment.http_response.ratelimit.fifteen_minutes_usage).to eq 1
  end
end

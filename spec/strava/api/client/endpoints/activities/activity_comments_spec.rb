require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_comments', vcr: { cassette_name: 'client/activity_comments' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns activity comments' do
    activity_comments = client.activity_comments(id: 1_946_417_534)
    expect(activity_comments).to be_a Enumerable
    expect(activity_comments.count).to eq 8
    activity_comment = activity_comments.first
    expect(activity_comment.id).to eq 443_703_635
    expect(activity_comment.activity_id).to eq 1_946_417_534
    expect(activity_comment.resource_state).to eq 2
    expect(activity_comment.text).to eq 'Молодчина!'
    expect(activity_comment.created_at).to eq Time.new(2018, 11, 0o5, 2, 31, 22, '-00:00').utc
    athlete = activity_comment.athlete
    expect(athlete).to be_a Strava::Models::Athlete
    expect(athlete.username).to eq 'zolotov'
    expect(athlete.id).to eq 501_473
  end
  it 'returns activity comments by id' do
    activity_comments = client.activity_comments(1_946_417_534)
    expect(activity_comments).to be_a Enumerable
    expect(activity_comments.count).to eq 8
  end
end

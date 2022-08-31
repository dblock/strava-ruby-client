# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity_comments', vcr: { cassette_name: 'client/activity_comments' } do
  include_context 'API client'
  it 'returns activity comments' do
    activity_comments = client.activity_comments(id: 3_958_491_750)
    expect(activity_comments).to be_a Enumerable
    expect(activity_comments.count).to eq 3
    activity_comment = activity_comments.first
    expect(activity_comment.id).to eq 808_412_522
    expect(activity_comment.activity_id).to eq 3_958_491_750
    expect(activity_comment.resource_state).to eq 2
    expect(activity_comment.text).to eq 'ich mag Bitche'
    expect(activity_comment.created_at).to eq Time.new('2020', '8', '24', '12', '4', '23', '-00:00').utc
    athlete = activity_comment.athlete
    expect(athlete).to be_a Strava::Models::Athlete
    expect(athlete.firstname).to eq 'Dario'
    expect(athlete.lastname).to eq 'S.'
    expect(athlete.id).to(eq(nil)) # privacy restriction cuts off commenting athlete id
  end
  it 'returns activity comments by id' do
    activity_comments = client.activity_comments(3_958_491_750)
    expect(activity_comments).to be_a Enumerable
    expect(activity_comments.count).to eq 3
  end
end

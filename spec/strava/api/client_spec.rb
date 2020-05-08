require 'spec_helper'

RSpec.describe Strava::Api::Client do
  before do
    Strava::Api::Config.reset
  end
  it_behaves_like 'web client'
  context 'errors' do
    it 'handles authorization errors', vcr: { cassette_name: 'client/authorization_error' } do
      expect { subject.activity(id: 1_946_417_534) }.to raise_error Strava::Errors::Fault, /Authorization Error/
    end
    it 'handles not found errors', vcr: { cassette_name: 'client/not_found_error' } do
      expect { subject.activity(id: 1_946_417_534) }.to raise_error Faraday::ResourceNotFound
    end
  end
end

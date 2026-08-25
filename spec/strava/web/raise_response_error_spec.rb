# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::RaiseResponseError do
  let(:middleware) { described_class.new }
  let(:env) { Struct.new(:status, :response_headers, :body).new(407, {}, {}) }

  describe '#on_complete' do
    it 'raises Faraday::ConnectionFailed for a 407 proxy authentication error' do
      expect { middleware.on_complete(env) }.to raise_error(
        Faraday::ConnectionFailed, '407 "Proxy Authentication Required "'
      )
    end
  end
end

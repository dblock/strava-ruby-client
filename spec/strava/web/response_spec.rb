# frozen_string_literal: true

require 'spec_helper'

FakeHttpResponse = Struct.new(:body)

describe Strava::Web::Response do
  let(:http_response) { FakeHttpResponse.new(body) }

  describe '#method_missing' do
    context 'when the response body is a Hash' do
      let(:body) { { 'foo' => 'bar' } }

      it 'delegates to the response body' do
        response = described_class.new(http_response)
        expect(response['foo']).to eq 'bar'
      end
    end

    context 'when the response body is an Array' do
      let(:body) { [{ 'foo' => 'bar' }] }

      it 'delegates to the response body' do
        response = described_class.new(http_response)
        expect(response.first['foo']).to eq 'bar'
      end
    end

    context 'when the response body is neither a Hash nor an Array' do
      let(:body) { FakeHttpResponse.new('nested-string') }

      it 'raises NoMethodError' do
        response = described_class.new(http_response)
        expect { response.foo }.to raise_error NoMethodError
      end
    end
  end
end

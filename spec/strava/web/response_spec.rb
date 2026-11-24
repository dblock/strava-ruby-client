# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::Response do
  let(:http_response) { Faraday::Response.new(Faraday::Env.from(status: 200, body: body)) }
  let(:response) { described_class.new(http_response) }

  describe '#method_missing' do
    context 'when the response body is a Hash' do
      let(:body) { { 'foo' => 'bar' } }

      it 'delegates to the response body' do
        expect(response['foo']).to eq 'bar'
      end

      it 'adds the http response to the body' do
        expect(response['http_response']).to be http_response
      end

      it 'does not mutate the original body' do
        response
        expect(http_response.body).to eq('foo' => 'bar')
      end
    end

    context 'when the response body is an Array' do
      let(:body) { [{ 'foo' => 'bar' }, nil] }

      it 'delegates to the response body' do
        expect(response.first['foo']).to eq 'bar'
      end

      it 'adds the http response to each row' do
        expect(response.map { |row| row['http_response'] }).to all(be(http_response))
      end

      it 'does not mutate the original body' do
        response
        expect(http_response.body).to eq([{ 'foo' => 'bar' }, nil])
      end
    end

    context 'when the response body is neither a Hash nor an Array' do
      let(:body) { 'nested-string' }

      it 'returns the body' do
        expect(response.response).to eq 'nested-string'
      end

      it 'raises NoMethodError' do
        expect { response.foo }.to raise_error NoMethodError
      end
    end
  end
end

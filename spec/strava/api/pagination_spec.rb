# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Api::Pagination do
  let(:web_response) { double('web_response', http_response: double('http_response')) }
  let(:collection) { %w[a b c] }
  let(:pagination) { described_class.new(collection, web_response) }

  describe '#collection' do
    it 'returns the underlying collection' do
      expect(pagination.collection).to eq collection
    end
  end

  describe '#size' do
    it 'delegates to the collection' do
      expect(pagination.size).to eq 3
    end
  end

  describe '#each' do
    it 'iterates over the collection' do
      expect { |b| pagination.each(&b) }.to yield_successive_args('a', 'b', 'c')
    end

    it 'returns the collection when no block is given' do
      expect(pagination.each).to eq collection
    end
  end

  describe 'method_missing' do
    it 'delegates unknown methods to the collection' do
      expect(pagination.first).to eq 'a'
      expect(pagination.last).to eq 'c'
    end
  end

  describe 'respond_to?' do
    it 'returns true for methods supported by the collection' do
      expect(pagination.respond_to?(:first)).to be true
    end

    it 'returns false for methods not supported by the collection' do
      expect(pagination.respond_to?(:not_a_real_method)).to be false
    end
  end
end

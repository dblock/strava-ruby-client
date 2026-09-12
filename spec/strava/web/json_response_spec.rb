# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::JsonResponse do
  let(:middleware) { described_class.new }

  describe '#parse' do
    it 'parses a JSON object body' do
      expect(middleware.send(:parse, '{"foo":"bar"}')).to eq('foo' => 'bar')
    end

    it 'parses a JSON array body' do
      expect(middleware.send(:parse, '[1,2,3]')).to eq([1, 2, 3])
    end

    it 'returns nil for an empty body' do
      expect(middleware.send(:parse, '')).to be_nil
    end

    it 'returns nil for a blank body' do
      expect(middleware.send(:parse, '   ')).to be_nil
    end

    it 'does not raise ArgumentError with json >= 3.0 keyword-only JSON.parse' do
      expect { middleware.send(:parse, '{}') }.not_to raise_error
    end
  end
end

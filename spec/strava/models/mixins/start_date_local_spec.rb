# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strava::Models::DetailedActivity do
  describe '#start_date_local' do
    context 'when start_date and start_date_local are the same' do
      let(:activity) do
        described_class.new(
          'start_date' => '2024-01-15T14:30:00Z',
          'start_date_local' => '2024-01-15T14:30:00Z'
        )
      end

      it 'returns the local time with no offset' do
        expect(activity.start_date_local.utc_offset).to eq 0
      end
    end

    context 'when start_date_local is behind start_date' do
      let(:activity) do
        described_class.new(
          'start_date' => '2024-01-15T14:30:00Z',
          'start_date_local' => '2024-01-15T09:30:00Z'
        )
      end

      it 'returns the local time with a negative offset' do
        expect(activity.start_date_local.utc_offset).to eq(-5 * 3600)
      end
    end

    context 'when start_date_local is ahead of start_date' do
      let(:activity) do
        described_class.new(
          'start_date' => '2024-01-15T14:30:00Z',
          'start_date_local' => '2024-01-15T19:30:00Z'
        )
      end

      it 'returns the local time with a positive offset' do
        expect(activity.start_date_local.utc_offset).to eq 5 * 3600
      end
    end

    context 'when a timezone property is present' do
      let(:activity) do
        described_class.new(
          'start_date' => '2024-01-15T14:30:00Z',
          'start_date_local' => '2024-01-15T09:30:00Z',
          'timezone' => '(GMT-05:00) America/New_York'
        )
      end

      it 'still derives the offset from the difference between start_date and start_date_local' do
        expect(activity.start_date_local.utc_offset).to eq(-5 * 3600)
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StreamStat::V do
  describe '#next' do
    context 'When V has 0 length' do
      subject { described_class.new.next(57) }

      its(:avg) { is_expected.to eq 57.0 }
      its(:variance) { is_expected.to eq 0.0 }
      its(:sd) { is_expected.to eq 0.0 }
    end

    context 'When calculated values from an item is given to V' do
      subject { described_class.new(1, sum([1]), variance([1]) * 1).next(2) }

      its(:avg) { is_expected.to eq avg [1, 2] }
      its(:variance) { is_expected.to eq variance [1, 2] }
      its(:sd) { is_expected.to eq sd [1, 2] }
    end

    context 'When calculated values is given to V' do
      subject { described_class.new(data.size, sum(data), variance(data) * data.size).next(57) }
      let(:data) { (1..100).to_a }

      its(:avg) { is_expected.to eq avg [*data, 57] }
      its(:variance) { is_expected.to eq variance [*data, 57] }
      its(:sd) { is_expected.to eq sd [*data, 57] }
    end
  end

  describe '#avg' do
    it 'returns 0 as a default' do
      expect(described_class.new.avg).to eq 0.0
    end

    it 'returns 0 when length is 0' do
      expect(described_class.new(0, 57).avg).to eq 0.0
    end

    it 'divides sum by length' do
      expect(described_class.new(3, 57).avg).to eq 19.0
    end
  end

  describe '#variance' do
    it 'returns 0 as a default' do
      expect(described_class.new.variance).to eq 0.0
    end

    it 'returns 0 when length is 0' do
      expect(described_class.new(0, 0, 57).variance).to eq 0.0
    end

    it 'divides variance_sum by length' do
      expect(described_class.new(3, 0, 57).variance).to eq 19.0
    end
  end

  describe '#sd' do
    it 'returns 0 as a default' do
      expect(described_class.new.sd).to eq 0.0
    end

    it 'returns 0 when length is 0' do
      expect(described_class.new(0, 0, 48).sd).to eq 0.0
    end

    it 'returns square root of variance' do
      expect(described_class.new(3, 0, 48).sd).to eq 4.0
    end
  end
end

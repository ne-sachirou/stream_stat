# frozen_string_literal: true

RSpec.describe StreamStat::V do
  describe '#next' do
    context 'When V has 0 length' do
      subject { described_class.new.next(57) }

      its(:avg) { is_expected.to eq 57.0 }
      its(:variance) { is_expected.to eq 0.0 }
      its(:sd) { is_expected.to eq 0.0 }
      its(:min) { is_expected.to eq 57.0 }
      its(:max) { is_expected.to eq 57.0 }
    end

    context 'When calculated values is given to V' do
      where :data, :item do
        [
          [[1], 2],
          [(1..1000).to_a, 57]
        ]
      end

      with_them do
        subject { described_class.new(data.size, avg(data), avg(data.collect { |i| i**2 }), data.min, data.max).next(item) }

        its(:avg) { is_expected.to fuzzy_eq avg [*data, item] }
        its(:variance) { is_expected.to fuzzy_eq variance [*data, item] }
        its(:sd) { is_expected.to fuzzy_eq sd [*data, item] }
        its(:min) { is_expected.to fuzzy_eq [*data, item].min }
        its(:max) { is_expected.to fuzzy_eq [*data, item].max }
      end
    end
  end

  describe '#avg' do
    it 'returns 0 as a default' do
      expect(described_class.new.avg).to eq 0.0
    end

    it 'returns avg' do
      expect(described_class.new(0, 57.0).avg).to eq 57.0
    end
  end

  describe '#variance' do
    it 'returns 0 as a default' do
      expect(described_class.new.variance).to eq 0.0
    end

    it 'returns variance' do
      expect(described_class.new(0, 3.0, 18.0).variance).to eq 9.0
    end
  end

  describe '#sd' do
    it 'returns 0 as a default' do
      expect(described_class.new.sd).to eq 0.0
    end

    it 'returns square root of variance' do
      expect(described_class.new(0, 3.0, 18.0).sd).to eq 3.0
    end
  end

  describe '#min' do
    it 'returns 0 as a default' do
      expect(described_class.new.min).to eq Float::INFINITY
    end

    it 'returns min' do
      expect(described_class.new(0, 0.0, 0.0, 57.0, 0.0).min).to eq 57.0
    end
  end

  describe '#max' do
    it 'returns 0 as a default' do
      expect(described_class.new.max).to eq(-Float::INFINITY)
    end

    it 'returns max' do
      expect(described_class.new(0, 0.0, 0.0, 0.0, 57.0).max).to eq 57.0
    end
  end
end

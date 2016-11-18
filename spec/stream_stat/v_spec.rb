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
        subject do
          v = described_class.new.instance_exec(data, method(:avg)) do |data, avg|
            @avg = avg[data]
            @square_avg = avg[data.collect { |i| i**2 }]
            @min = data.min
            @max = data.max
            @count = data.size
            self
          end
          v.next item
        end

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
      v = described_class.new.instance_eval do
        @avg = 57.0
        self
      end
      expect(v.avg).to eq 57.0
    end
  end

  describe '#variance' do
    it 'returns 0 as a default' do
      expect(described_class.new.variance).to eq 0.0
    end

    context 'avg=3.0 & square_avg=18.0' do
      subject do
        described_class.new.instance_eval do
          @avg = 3.0
          @square_avg = 18.0
          self
        end
      end

      its(:variance) { is_expected.to eq 9.0 }
    end
  end

  describe '#sd' do
    it 'returns 0 as a default' do
      expect(described_class.new.sd).to eq 0.0
    end

    context 'avg=3.0 & square_avg=18.0' do
      subject do
        described_class.new.instance_eval do
          @avg = 3.0
          @square_avg = 18.0
          self
        end
      end

      its(:sd) { is_expected.to eq 3.0 }
    end
  end

  describe '#min' do
    it 'returns INFINITY as a default' do
      expect(described_class.new.min).to eq Float::INFINITY
    end

    it 'returns min' do
      v = described_class.new.instance_eval do
        @min = 57.0
        self
      end
      expect(v.min).to eq 57.0
    end
  end

  describe '#max' do
    it 'returns -INFINITY as a default' do
      expect(described_class.new.max).to eq(-Float::INFINITY)
    end

    it 'returns max' do
      v = described_class.new.instance_eval do
        @max = 57.0
        self
      end
      expect(v.max).to eq 57.0
    end
  end
end

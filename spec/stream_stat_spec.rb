# frozen_string_literal: true

RSpec.describe StreamStat do
  describe '#each' do
    it 'return an Enumerable' do
      expect(described_class.new([]).each).to be_a Enumerable
    end

    context 'When iterates with data' do
      let(:data) { (1..100).to_a }
      let :expected do
        1.upto(data.size)
         .collect { |i| data.take i }
         .collect { |data| { avg: avg(data), variance: variance(data), sd: sd(data), min: data.min, max: data.max } }
      end

      it 'iterates statistic result with streaming' do
        actual = []
        described_class.new(data).each { |stat| actual << { avg: stat.avg, variance: stat.variance, sd: stat.sd, min: stat.min, max: stat.max } }
        expect(actual).to fuzzy_eq expected
      end

      it 'returns an Enumerable which iterates statistic result' do
        actual = described_class.new(data).lazy.collect { |stat| { avg: stat.avg, variance: stat.variance, sd: stat.sd, min: stat.min, max: stat.max } }.to_a
        expect(actual).to fuzzy_eq expected
      end
    end
  end
end

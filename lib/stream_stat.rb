# frozen_string_literal: true

# StreamStat: Aggregate large data statictics with streaming.
#
# = StreamStat
# A library to aggragate statistics of large data with streaming, less memory.
#
# == Usage
# Aggragate a SD of large_data.
#
#   p StreamStat.new(large_data).inject { |_a, stat| stat }.sd
#
# View the intermediate results.
#
#   p StreamStat.new(large_data)
#               .lazy
#               .each_with_index
#               .inject { |_a, r| stat, i = r; p stat.sd if i % 100 == 0; stat }
#               .sd
class StreamStat
  include Enumerable

  # Accumrator.
  #
  # This holds :avg, :variance & :sd.
  class V
    def initialize(length = 0, sum = 0, variance_sum = 0.0)
      @length = length
      @sum = sum
      @variance_sum = variance_sum
    end

    def next(item)
      self.class.new(
        @length + 1,
        @sum + item,
        next_variance_sum(avg, (@sum + item).to_f / (@length + 1), item)
      )
    end

    def avg
      @length.zero? ? 0.0 : @sum.to_f / @length
    end

    def variance
      @length.zero? ? 0.0 : @variance_sum / @length
    end

    def sd
      Math.sqrt variance
    end

    private

    def next_variance_sum(current_avg, next_avg, item)
      (@variance_sum + (next_avg**2 - current_avg**2) * @length + 2 * (current_avg - next_avg) * @sum) + (item - next_avg)**2
    end
  end

  def initialize(enum)
    @enum = enum
  end

  def each
    ys = Enumerator.new do |y|
      @enum.inject(V.new) do |v1, item|
        v2 = v1.next item
        y << v2
        v2
      end
    end
    ys.each { |stat| yield stat } if block_given?
    ys
  end
end

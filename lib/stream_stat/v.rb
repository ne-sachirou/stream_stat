# frozen_string_literal: true

class StreamStat
  # Accumrator.
  #
  # This holds :avg, :variance, :sd, :min & :max
  class V
    attr_reader :avg, :min, :max

    # @param [Integer] count
    # @param [Float] avg
    # @param [Float] square_avg
    # @param [Float] min
    # @param [Float] max
    def initialize(count = 0, avg = 0.0, square_avg = 0.0, min = Float::INFINITY, max = -Float::INFINITY)
      @count = count
      @avg = avg
      @square_avg = square_avg
      @min = min
      @max = max
    end

    # @param [Numeric] item
    # @return [StreamStat::V]
    def next(item)
      item = item.to_f
      next_length = @count + 1
      self.class.new(
        next_length,
        next_avg(next_length, item),
        next_square_avg(next_length, item),
        [@min, item].min,
        [@max, item].max
      )
    end

    # @return [Float]
    def variance
      @square_avg - @avg**2
    end

    # @return [Float]
    def sd
      Math.sqrt variance
    end

    private

    def next_avg(next_length, item)
      @avg + (item - @avg) / next_length
    end

    def next_square_avg(next_length, item)
      @square_avg + (item**2 - @square_avg) / next_length
    end
  end
end

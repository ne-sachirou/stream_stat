# frozen_string_literal: true

require_relative 'experimental'

class StreamStat
  # Accumrator.
  #
  # This holds :avg, :variance, :sd, :min & :max
  class V
    # @!attribute [r] avg
    #   @return [Float] average
    # @!attribute [r] min
    #   @return [Float] minimum
    # @!attribute [r] max
    #   @return [Float] maximum
    # @!attribute [r] experimental
    #   @return [StreamStat::Experimental] experimental calculator
    attr_reader :avg, :min, :max, :experimental

    def initialize
      @avg = 0.0
      @square_avg = 0.0
      @min = Float::INFINITY
      @max = -Float::INFINITY
      @count = 0
      @experimental = Experimental.new
    end

    # @param [Numeric] item
    # @return [self]
    def next(item)
      item = item.to_f
      next_length = @count + 1
      @avg = next_avg next_length, item
      @square_avg = next_square_avg next_length, item
      @min = [@min, item].min
      @max = [@max, item].max
      @count = next_length
      @experimental.next item
      self
    end

    # @return [Float] variance
    def variance
      @square_avg - @avg**2
    end

    # @return [Float] standard deviation
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

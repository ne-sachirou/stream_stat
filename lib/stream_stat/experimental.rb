# frozen_string_literal: true

class StreamStat
  # Experimental midium & mode.
  class Experimental
    attr_reader :sample

    def initialize
      @count = 0
      @sample = []
    end

    def next(item)
      next_length = @count + 1
      @sample = next_sample next_length, item
      @count = next_length
      self
    end

    def medium_of_sample
      sample_size = @sample.size
      sorted_sample = @sample.sort
      if sample_size.even?
        sorted_sample[sample_size / 2 - 1]
      else
        (sorted_sample[sample_size / 2 - 1] + sorted_sample[sample_size / 2]) / 2.0
      end
    end

    private

    def next_sample(next_length, item)
      log_count = Math.log next_length
      i = rand next_length
      if @sample.size < log_count
        @sample << item
      elsif i < log_count
        @sample[i] = item
      end
      @sample
    end
  end
end

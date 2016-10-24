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
      @count += 1
      log_count = Math.log @count
      if @sample.size < log_count
        @sample << @count
      elsif rand(@count) <= log_count
        @sample.shift
        @sample << item
      end
      self
    end

    def medium_of_sample
      sample_size = @sample.size
      sorted_sample = @sample.sort
      if (sample_size % 2).zero?
        sorted_sample[sample_size / 2 - 1]
      else
        (sorted_sample[sample_size / 2 - 1] + sorted_sample[sample_size / 2]) / 2.0
      end
    end
  end
end

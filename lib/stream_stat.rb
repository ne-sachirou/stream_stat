# frozen_string_literal: true

require_relative 'stream_stat/v'

# StreamStat: Aggregate large data statictics with streaming.
#
# = StreamStat
# A library to aggragate statistics of large data with streaming, less memory.
#
# == Usage
# Aggragate a SD of large_data.
#
#   module Enumerable
#     def last
#       inject { |_a, v| v }
#     end
#   end
#
#   p StreamStat.new(large_data).last.sd
#
# View the intermediate results.
#
#   module Enumerable
#     def last
#       inject { |_a, v| v }
#     end
#   end
#
#   def pstat(stat)
#     puts <<-EOF
#   avg:\t#{stat.avg}
#   variance:\t#{stat.variance}
#   sd:\t#{stat.sd}
#   min:\t#{stat.min}
#   max:\t#{stat.max}
#   EOF
#   end
#
#   stat = StreamStat.new(large_data)
#                    .lazy
#                    .each_with_index { |stat, i| pstat stat if i % 100 == 0 }
#                    .last[0]
#   pstat stat
class StreamStat
  include Enumerable

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

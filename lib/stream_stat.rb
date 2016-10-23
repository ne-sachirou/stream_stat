# frozen_string_literal: true

require_relative 'stream_stat/v'

# StreamStat: Aggregate large data statictics with streaming.
class StreamStat
  include Enumerable

  # @param [Enumerable] enum
  def initialize(enum)
    @enum = enum
  end

  # @yield [StreamStat::V]
  # @return [Enumerable<StreamStat::V>]
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

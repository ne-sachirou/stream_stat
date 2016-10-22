# frozen_string_literal: true

# Aggragate a SD of large_data.

# Monkey patch
module Enumerable
  def last
    inject { |_a, v| v }
  end
end

large_data = (1..100_000).lazy.collect { rand 100_000 }
p StreamStat.new(large_data).last.sd

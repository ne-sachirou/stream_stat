# frozen_string_literal: true

# View the intermediate results.

# Monkey patch
module Enumerable
  def each_tap
    collect do |*item|
      yield(*item)
      [*item]
    end
  end

  def last
    inject { |_a, v| v }
  end
end

def pstat(stat)
  puts <<-EOF
avg:\t#{stat.avg}
variance:\t#{stat.variance}
sd:\t#{stat.sd}
min:\t#{stat.min}
max:\t#{stat.max}
EOF
end

large_data = (1..100_000).lazy.collect { rand 100_000 }
stat = StreamStat.new(large_data)
                 .lazy
                 .each_with_index
                 .each_tap { |st, i| pstat st if (i % 10_000).zero? }
                 .last[0]
pstat stat

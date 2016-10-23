StreamStat: Aggregate large data statictics with streaming.

[![Gem Version](https://badge.fury.io/rb/stream_stat.svg)](https://badge.fury.io/rb/stream_stat)
[![Dependency Status](https://gemnasium.com/badges/github.com/ne-sachirou/stream_stat.svg)](https://gemnasium.com/github.com/ne-sachirou/stream_stat)
[![Build Status](https://travis-ci.org/ne-sachirou/stream_stat.svg?branch=master)](https://travis-ci.org/ne-sachirou/stream_stat)
[![Code Climate](https://codeclimate.com/github/ne-sachirou/stream_stat/badges/gpa.svg)](https://codeclimate.com/github/ne-sachirou/stream_stat)
[![Test Coverage](https://codeclimate.com/github/ne-sachirou/stream_stat/badges/coverage.svg)](https://codeclimate.com/github/ne-sachirou/stream_stat/coverage)

StreamStat
==
A library to aggragate statistics of large data with streaming, less memory.

Currently supported are:

- average 平均 `:avg`
- variance 分散 `:variance`
- standard deviation 標準偏差 `:sd`
- minimun 最小値 `:min`
- maximum 最大値 `:max`

Usage
--

Aggragate a SD of large_data.

```ruby
# Monkey patch
module Enumerable
  def last
    inject { |_a, v| v }
  end
end

large_data = (1..100_000).lazy.collect { rand 100_000 }
p StreamStat.new(large_data).last.sd
```

View the intermediate results.

```ruby
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
```

[doc](http://www.rubydoc.info/gems/stream_stat)

Installation
--
Add this line to your application's Gemfile:

```ruby
gem 'stream_stat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stream_stat

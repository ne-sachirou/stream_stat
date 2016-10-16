StreamStat: Aggregate large data statictics with streaming.

[![Gem Version](https://badge.fury.io/rb/stream_stat.svg)](https://badge.fury.io/rb/stream_stat)
[![Dependency Status](https://gemnasium.com/badges/github.com/ne-sachirou/stream_stat.svg)](https://gemnasium.com/github.com/ne-sachirou/stream_stat)
[![Build Status](https://travis-ci.org/ne-sachirou/stream_stat.svg?branch=master)](https://travis-ci.org/ne-sachirou/stream_stat)
[![Code Climate](https://codeclimate.com/github/ne-sachirou/stream_stat/badges/gpa.svg)](https://codeclimate.com/github/ne-sachirou/stream_stat)
[![Test Coverage](https://codeclimate.com/github/ne-sachirou/stream_stat/badges/coverage.svg)](https://codeclimate.com/github/ne-sachirou/stream_stat/coverage)

StreamStat
==
A library to aggragate statistics of large data with streaming, less memory.

Currently average (`:avg`), variance (`:variance`), standard deviation (`:sd`), minimun (`:min`) & maximum (`:max`) are supported.

Usage
--
Aggragate a SD of large_data.

```ruby
module Enumerable
  def last
    inject { |_a, v| v }
  end
end

p StreamStat.new(large_data).last.sd
```

View the intermediate results.

```ruby
module Enumerable
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

stat = StreamStat.new(large_data)
                 .lazy
                 .each_with_index { |stat, i| pstat stat if i % 100 == 0 }
                 .last[0]
pstat stat
```

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

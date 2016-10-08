StreamStat: Aggregate large data statictics with streaming.

[![Gem Version](https://badge.fury.io/rb/stream_stat.svg)](https://badge.fury.io/rb/stream_stat)
[![Dependency Status](https://gemnasium.com/badges/github.com/ne-sachirou/stream_stat.svg)](https://gemnasium.com/github.com/ne-sachirou/stream_stat)
[![Build Status](https://travis-ci.org/ne-sachirou/stream_stat.svg?branch=master)](https://travis-ci.org/ne-sachirou/stream_stat)
[![Code Climate](https://codeclimate.com/github/ne-sachirou/stream_stat/badges/gpa.svg)](https://codeclimate.com/github/ne-sachirou/stream_stat)
[![Test Coverage](https://codeclimate.com/github/ne-sachirou/stream_stat/badges/coverage.svg)](https://codeclimate.com/github/ne-sachirou/stream_stat/coverage)

StreamStat
==
A library to aggragate statistics of large data with streaming, less memory.

Currently average (`:avg`), variance (`:variance`) & standard deviation (`:sd`) are supported.

Usage
--
Aggragate a SD of large_data.

```ruby
p StreamStat.new(large_data).inject { |_a, stat| stat }.sd
```

View the intermediate results.

```ruby
stat = StreamStat.new(large_data)
                 .lazy
                 .each_with_index
                 .inject { |_a, r|
                   stat, i = r
                   if i % 100 == 0
                     puts <<-EOF
avg:\t#{stat.avg}
variance:\t#{stat.variance}
sd:\t#{stat.sd}
EOF
                   end
                   stat
                 }
puts <<-EOF
avg:\t#{stat.avg}
variance:\t#{stat.variance}
sd:\t#{stat.sd}
EOF
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

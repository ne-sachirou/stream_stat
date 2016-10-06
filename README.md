StreamStat: Aggregate large data statictics with streaming.

[![Gem Version](https://badge.fury.io/rb/stream_stat.svg)](https://badge.fury.io/rb/stream_stat)
[![Build Status](https://travis-ci.org/ne-sachirou/stream_stat.svg?branch=master)](https://travis-ci.org/ne-sachirou/stream_stat)

StreamStat
==
A library to aggragate statistics of large data with streaming, less memory.

Usage
--
Aggragate a SD of large_data.

```ruby
p StreamStat.new(large_data).inject { |_a, stat| stat }.sd
```

View the intermediate results.

```ruby
p StreamStat.new(large_data)
            .lazy
            .each_with_index
            .inject { |_a, r| stat, i = r; p stat.sd if i % 100 == 0; stst }
            .sd
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

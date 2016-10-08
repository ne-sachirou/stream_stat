# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stream_stat/version'

Gem::Specification.new do |spec|
  spec.name          = 'stream_stat'
  spec.version       = StreamStat::VERSION
  spec.authors       = ['ne_Sachirou']
  spec.email         = ['utakata.c4se@gmail.com']

  spec.summary       = 'StreamStat: Aggregate large data statictics with streaming.'
  spec.description   = 'A library to aggragate statistics of large data with streaming, less memory.'
  spec.homepage      = 'https://github.com/ne-sachirou/stream_stat'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
end

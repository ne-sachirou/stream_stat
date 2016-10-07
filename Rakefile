# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rubocop-rspec'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new

desc 'Test.'
task test: %i(rubocop spec)

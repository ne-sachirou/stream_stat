# frozen_string_literal: true

require 'bundler/gem_tasks'

desc 'Test.'
task :test do
  sh 'bundle exec rubocop -r rubocop-rspec'
  sh 'bundle exec rspec'
end

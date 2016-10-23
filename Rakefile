# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rubocop-rspec'
require 'yard'
require 'yard/rake/yardoc_task'
require_relative 'example/example'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new
YARD::Rake::YardocTask.new

desc 'Generate doc.'
task doc: %i(readme yard) do
  puts '`bundle exec yard server` to check the doc.'
end

task :readme do
  @examples = Example.all
  readme = ERB.new(File.read("#{__dir__}/README.md.erb", encoding: Encoding::UTF_8)).result.strip + "\n"
  File.write "#{__dir__}/README.md", readme
end

desc 'Test'
task test: %i(rubocop spec)

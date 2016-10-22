# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rubocop-rspec'
require_relative 'example/example'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new

desc 'Render readme'
task :readme do
  @examples = Example.all
  readme = ERB.new(File.read("#{__dir__}/README.md.erb", encoding: Encoding::UTF_8)).result.strip + "\n"
  File.write "#{__dir__}/README.md", readme
end

desc 'Test'
task test: %i(rubocop spec)

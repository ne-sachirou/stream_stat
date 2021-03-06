# frozen_string_literal: true

require 'simplecov'
require 'rspec/its'
require 'rspec-parameterized'
Dir["#{__dir__}/support/*.rb"].each { |rb| require_relative rb }

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

$LOAD_PATH.unshift "#{__dir__}/../lib"
require 'stream_stat'

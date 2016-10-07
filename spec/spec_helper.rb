# frozen_string_literal: true

require 'codeclimate-test-reporter'
require 'rspec/its'
Dir["#{__dir__}/support/*.rb"].each { |rb| require_relative rb }

CodeClimate::TestReporter.start

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

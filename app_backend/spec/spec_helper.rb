# debugging
require 'pry-byebug'

# activate mocks for network
require 'webmock/rspec'

RSpec.configure do |config|
  ##### default options
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = true
  config.order = :random
  Kernel.srand config.seed
end

# test coverage config
require 'simplecov'
SimpleCov.start

# require the app (so the files)
require './app_backend.rb'
# allow isolated testing environment
require 'rack/test'

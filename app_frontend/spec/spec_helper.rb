# debugging
require 'pry-byebug'

# browser automation library
require 'selenium-webdriver'

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

# load the support files for integration
Dir[File.expand_path('./spec/support/*.rb')].map { |f| require f }

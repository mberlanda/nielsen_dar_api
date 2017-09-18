# frozen_string_literal: true

require 'bundler/setup'
require 'nielsen_dar_api'

require 'support/test_configuration'
include Support::TestConfiguration

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.configure do |config|
  config.before(:all) do
    restore_default_configuration
  end
end

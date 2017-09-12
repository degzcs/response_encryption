$LOAD_PATH.unshift(File.dirname(__FILE__))

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb", __FILE__)

require "bundler/setup"
require "response_encryption"
Dir[File.join('./lib/response_encryption/**/*.rb')].each { |f| require f }
Dir[File.join('./spec/support/**/*.rb')].each { |f| require f }
require 'rspec/rails'
require 'pry'

ResponseEncryption.configure do |config|
  config.enabled = true
  config.encryption_strategy = :encrypted_attributes
  config.serializer_gem = :none # :active_model_serializers, :jsonapi_resources
  config.algothim = 'AES'
  config.algorithm_key_length = '256'
  config.block_cipher_mode = 'CBC'
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Rails::RequestExampleGroup, type: :feature
  config.include EncryptHelper
end

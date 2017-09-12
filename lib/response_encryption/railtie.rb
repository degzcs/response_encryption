# frozen_string_literal: true

require "response_encryption"
require "rails"

module ResponseEncryption
  class Railtie < Rails::Railtie # :nodoc:
    #
    #   Set up our default config options
    #   Do this before the app initializers run so we don't override custom settings
    #
    config.before_initialize do
      ResponseEncryption.configure do |config|
        config.enabled = true
        config.encryption_strategy = :encrypted_attributes # encrypted_body
        config.serializer_gem = :none # :json-resource, :active_serializer
        config.algothim = 'AES'
        config.algorithm_key_length = '256'
        config.block_cipher_mode = 'CBC'
      end
    end
  end
end
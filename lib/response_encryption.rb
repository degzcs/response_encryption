require 'response_encryption/railtie' if defined?(Rails)
# # require 'active_support/core_ext/object/blank'

require "response_encryption/version"
require "response_encryption/active_model_service"
require "response_encryption/asymmetric_encrypter"
require "response_encryption/symmetric_encrypter"
require "response_encryption/act_as_a_encryption_controller"
require "response_encryption/encrypt_attributes"
require "response_encryption/serialization_ext"


module ResponseEncryption
  class << self

    WRITER_METHODS  = []
    ACCESSOR_METHODS = [:serializer_gem, :algothim, :algorithm_key_length, :block_cipher_mode, :enabled, :cipher, :encryption_strategy]

    attr_accessor(*ACCESSOR_METHODS)
    attr_writer(*WRITER_METHODS)

    def configure
      yield self if block_given?
      raise "The serializer_gem value is invalid. Please select one of these: #{ available_serializer_gems.join(', ') }" unless available_serializer_gems.include? serializer_gem
      raise "The available_encryption_strategies value is invalid. Please select one of these: #{ available_serializer_gems.join(', ') }" unless available_encryption_strategies.include? encryption_strategy
    end

    def cipher
      @cipher = OpenSSL::Cipher.new("#{ algothim }-#{ algorithm_key_length }-#{ block_cipher_mode }")
    end

    def available_serializer_gems
      %i(active_model_serializers jsonapi_resources none)
    end

    def available_encryption_strategies
      %i(encrypted_attributes encrypted_body)
    end

    def encrypted_attributes_strategy?
      self.encryption_strategy == :encrypted_attributes
    end

    def encrypted_body_strategy?
      self.encryption_strategy == :encrypted_body
    end

    def active_model_serializers?
      self.serializer_gem == :active_model_serializers
    end

    def jsonapi_resources?
      self.serializer_gem == :jsonapi_resources
    end
  end
end

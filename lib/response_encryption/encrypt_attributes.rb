module ResponseEncryption::EncryptAttributes
  extend ActiveSupport::Concern

  included do
    def initialize(object,  options)
      super(object, options)
      context = context_from(options)
      if ResponseEncryption.encrypted_attributes_strategy?
        raise(ActionController::ParameterMissing, 'You must to set the context for the resource/serializer') if context.blank?
        symmetric_key = symmetric_key_from(context[:subdomain])
        @encrypter = Encryption::SymmetricEncrypter.new(iv: context[:nonce], key: symmetric_key)
        self.class.encrypt_attributes!(object)
      end
    end

    def context_from(param)
      case ResponseEncryption.serializer_gem
      when :active_model_serializers
         param[:context]
      when :jsonapi_resources
        param
      when :none
        raise 'pending!!'
      end
    end

    # TODO change this to remove Tenant!!!
    def symmetric_key_from(subdomain)
      tenant = Tenant.find_by(subdomain: subdomain)
      fail ActiveRecord::RecordNotFound, "The subdomain #{ subdomain } not found" if tenant.blank?
      tenant.symmetric_key
    end

    def cipher
      @encrypter.cipher
    end
  end

  module ClassMethods
    attr_accessor :encrypted_attrs
    def encrypted_attrs(*attributes)
      @encrypted_attrs = attributes.map { |attr| attr.to_s }
    end

    def encrypt_attributes!(model)
      @encrypted_attrs.each do |column_name|
        if model.respond_to? column_name
          define_method(column_name) do
            @encrypter.encrypt(model.__send__(column_name).try(:to_s))
          end
        else
          # TODO: get methods form Serializer
        end
      end
    end
  end
end

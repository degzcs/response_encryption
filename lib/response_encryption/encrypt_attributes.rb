module ResponseEncryption::EncryptAttributes
  extend ActiveSupport::Concern

  included do
    def initialize(object,  options)
      super(object, options)
      context = context_from(options)
      if ResponseEncryption.encrypted_attributes_strategy?
        raise(ActionController::ParameterMissing, 'You must to set the context for the resource/serializer') if context.blank?
        @encrypter = ResponseEncryption::SymmetricEncrypter.new(encoded_iv: context[:encoded_nonce], encoded_key: context[:encoded_symmetric_key])
        self.class.encrypt_attributes!(object)
      end
    end

    # Retrieve the context variable that will be send to the Serializer or Resource in order to pass
    # some important variables.
    # @param param [ Hash ]
    # @return [ Hash ]
    def context_from(param)
      case ResponseEncryption.serializer_gem
      when :active_model_serializers
         raise "You must to set encoded_symmetric_key option in the context hash" if param[:context]&.slice(:encoded_symmetric_key).blank?
         param[:context]
      when :jsonapi_resources
        raise "You must to set encoded_symmetric_key option in the context hash" if param[:encoded_symmetric_key].blank?
        param
      when :none
        raise 'pending!!'
      end
    end

    def cipher
      ResponseEncryption.cipher
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

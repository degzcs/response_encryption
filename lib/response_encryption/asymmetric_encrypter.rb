module ResponseEncryption
  class AsymmetricEncrypter < ResponseEncryption::ActiveModelService
    attr_reader :public_key, :encrypted_data

    def initialize(options={})
      validate(options)
      @public_key = OpenSSL::PKey::RSA.new(options[:public_key])
    end

    # @param data [ Object ] which should respond to #to_s
    # @param encode_data [ Boolean ]
    # @return [ String ] with the encrypted and encoded information
    def encrypt(data, encode_data = true)
      return data if data.blank?
      encrypted = public_key.public_encrypt(data.to_s)
      @encrypted_data = encode_data ? Base64.encode64(encrypted) : encrypted
    end

    def validate(options)
      errors.add(:param_missing, 'You must to provide public_key option') if options[:public_key].blank?
    end
  end
end
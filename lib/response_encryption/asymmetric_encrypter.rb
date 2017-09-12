module ResponseEncryption
  class AsymmetricEncrypter < ResponseEncryption::ActiveModelService
    attr_reader :public_key, :encrypted_data

    def initialize(options={})
      validate(options)
      @public_key = OpenSSL::PKey::RSA.new(options[:public_key])
    end

    # @param data [ Object ] which should respond to #to_s
    # @param data_encoded [ Boolean ]
    # @return [ String ] with the encrypted and encoded information
    def encrypt(data, data_encoded = true)
      return data if data.blank?
      encrypted = public_key.public_encrypt(data.to_s)
      @encrypted_data = data_encoded ? Base64.encode64(encrypted) : encrypted
    end

    def validate(options)
      errors.add(:param_missing, 'You must to provide public_key option') if options[:public_key].blank?
    end
  end
end
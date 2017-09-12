module ResponseEncryption
  class SymmetricEncrypter < ResponseEncryption::ActiveModelService
    attr_reader :cipher, :iv, :key, :encrypted_data

    def initialize(options={})
      validate(options)
      @cipher = ResponseEncryption.cipher
      @iv = Base64.decode64(options[:encoded_iv])
      @key = Base64.decode64(options[:encoded_key])
    end

    # @param data [ Object ] which respond to #to_s
    # @param encode_data [ Boolean ]
    # @return [ String ] with the encrypted and encoded information
    def encrypt(data, encode_data = true)
      return data if data.blank?
      cipher.encrypt
      cipher.key = key
      # This is the initial vector that we will use as nonce code.
      # This nonce is going in the headers as a 'Replay-Nonce'
      cipher.iv = iv
      encrypted = cipher.update(data.to_s) + cipher.final
      @encrypted_data = encode_data ? Base64.encode64(encrypted) : encrypted
    end

    def validate(options)
      errors.add(:param_missing, 'You must to set the encoded_iv (nonce) option') if options[:iv].blank?
      errors.add(:param_missing, 'You must to set the encoded_key (symmetric-key) option') if options[:key].blank?
    end

    class << self
      def encoded_nonce
        Base64.encode64(ResponseEncryption.cipher.random_iv)
      end
    end
  end
end
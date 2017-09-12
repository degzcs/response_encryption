module EncryptHelper
  # @param encoded_encrypted [ String ] base 64 encoded
  # @param nonce [ String ]
  # @return [ String ] with the information decrypted
  def decode_and_decrypt_asymmetric(encoded_encrypted, private_key_content)
    private_key = OpenSSL::PKey::RSA.new(private_key_content)
    encrypted_data = Base64.decode64(encoded_encrypted)
    private_key.private_decrypt(encrypted_data)
  end
end

require 'response_encryption/serialization_ext'
module ResponseEncryption
  module ActsAsEncryptionController
    extend ActiveSupport::Concern

    included do
      before_action :add_nonce_header

      # @return [ Hash ]
      def default_context
        @encoded_nonce ||= ResponseEncryption::SymmetricEncrypter.encoded_nonce
        {
          encoded_nonce: @encoded_nonce,
         }
      end

      private

      def add_nonce_header
        response.headers['Replay-Nonce'] = context[:encoded_nonce]
      end
    end
  end
end

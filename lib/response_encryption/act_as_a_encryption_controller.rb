module ResponseEncryption
  module ActsAsEncryptionController
    extend ActiveSupport::Concern

    included do
      before_action :add_nonce_header

      # @return [ Hash ]
      def context
        @nonce ||= ResponseEncryption::SymmetricEncrypter.encoded_nonce
        {
          subdomain: request.headers['Subdomain'],
          nonce: @nonce
         }
      end

      private

      def add_nonce_header
        response.headers['Replay-Nonce'] = context[:nonce]
      end
    end
  end
end

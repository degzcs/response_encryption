require "spec_helper"

RSpec.describe ResponseEncryption::ActsAsEncryptionController, type: :request do
  context 'Encrypted data' do
    before :each do
      # IMPORTANT: This value wil be saved into a database or a plain file in a secret way
      ENCODED_FAKE_SYMMETRIC_KEY= "/XtrzxtbgOYEoVZT3pTG/qhFUrenM4ftn6IqIsemy2c=\n".freeze
      ResponseEncryption.configure do |config|
        config.serializer_gem = :jsonapi_resources # :active_model_serializers, :jsonapi_resources
      end
    end

    it 'returns the organization details' do
      expected_response = {
        'tax_number' => '123456789',
        'name' => 'Company1',
        'address' => 'Street 1',
        'post_code' => 'AQ122',
        'phone_number' => '30021234',
        'email' => 'test@test.com'
      }
      organization = Organization.create(expected_response)
      get "http://api.example.com:3000/organizations/#{ organization.id }",
        params: {},
        headers: {}

      encoded_nonce = response.headers['Replay-Nonce']
      JSON.parse(response.body)['data']['attributes'].each do |key, encoded_encrypted_data|
        response_value = decode_and_decrypt(encoded_encrypted_data, encoded_nonce, ENCODED_FAKE_SYMMETRIC_KEY)
        expect(response_value).to eq expected_response[key]
      end
      expect(response.status).to eq 200
    end
  end
end
require "spec_helper"

RSpec.describe ResponseEncryption::AsymmetricEncrypter do
  let(:public_key){ File.read('./spec/fixtures/public_key.pem') }
  let(:private_key){ File.read('./spec/fixtures/private_key.pem') }
  let(:encrypter){ ResponseEncryption::AsymmetricEncrypter.new(public_key: public_key) }
  it "should encrypt and encode the given data" do
    original_data = { this: {is: 'a test', with: 'a Hash as a data'}}
    encoded_encrypted_data = encrypter.encrypt(original_data)
    data = decode_and_decrypt_asymmetric(encoded_encrypted_data, private_key)
    expect(data).to eq original_data.to_s
  end
end

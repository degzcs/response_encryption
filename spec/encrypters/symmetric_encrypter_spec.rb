require "spec_helper"

RSpec.describe ResponseEncryption::SymmetricEncrypter do

  let(:encrypter){ ResponseEncryption::SymmetricEncrypter.new(encoded_iv: ENCODED_FAKE_IV, encoded_key: ENCODED_FAKE_SYMMETRIC_KEY) }

  it "should encrypt and encode the given data" do
    original_data = { this: {is: 'a test', with: 'a Hash as a data'}}
    encoded_encrypted_data = encrypter.encrypt(original_data)
    data = decode_and_decrypt(encoded_encrypted_data, ENCODED_FAKE_IV, ENCODED_FAKE_SYMMETRIC_KEY)
    expect(data).to eq original_data.to_s
  end
end

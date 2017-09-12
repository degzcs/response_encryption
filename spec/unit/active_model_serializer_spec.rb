require "spec_helper"

RSpec.describe ResponseEncryption::ActsAsEncryptionController, type: :request do
  it 'should be a valid app' do
    expect(::Rails.application).to be_a(Dummy::Application)
  end
  context 'data NO encrypted' do
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

      expect(JSON.parse(response.body)).to include expected_response
      expect(response.status).to eq 200
    end
  end
end
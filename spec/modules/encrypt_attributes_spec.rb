require 'spec_helper'

RSpec.describe ResponseEncryption::EncryptAttributes do

  before do
    ResponseEncryption.serializer_gem= :jsonapi_resources
    class DumpResource < JSONAPI::Resource
      abstract
      include ResponseEncryption::EncryptAttributes

      attribute :name
      attribute :tax_number
      encrypted_attrs :name, :tax_number
    end

    class DumpClass
      attr_accessor :name, :tax_number

      def id
        nil
      end

      def initialize(options={})
        @name = options[:name]
        @tax_number = options[:tax_number]
      end
    end
  end

  after :each do
  ResponseEncryption.serializer_gem= :none
  end

  it 'should encrypt all selected fields' do
    expected_data = {
      tax_number: '123456789',
      name: 'fake company'
    }
    dump_instance = DumpClass.new(expected_data)
    resource = DumpResource.new(dump_instance, { encoded_nonce: ENCODED_FAKE_IV, encoded_symmetric_key: ENCODED_FAKE_SYMMETRIC_KEY })
    expect(decode_and_decrypt(resource.name, ENCODED_FAKE_IV, ENCODED_FAKE_SYMMETRIC_KEY)).to eq expected_data[:name]
    expect(decode_and_decrypt(resource.tax_number, ENCODED_FAKE_IV, ENCODED_FAKE_SYMMETRIC_KEY)).to eq expected_data[:tax_number]
  end
end

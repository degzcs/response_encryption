class OrganizationResource < JSONAPI::Resource
  include ResponseEncryption::EncryptAttributes

  #
  # Attribtues
  #

  attribute :tax_number
  attribute :name
  attribute :address
  attribute :post_code
  attribute :phone_number
  attribute :email

  encrypted_attrs :tax_number, :name, :phone_number, :post_code, :email, :address
end

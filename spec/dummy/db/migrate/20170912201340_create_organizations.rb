class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :tax_number
      t.string :address
      t.string :phone_number
      t.string :post_code
      t.string :email

      t.timestamps
    end
  end
end

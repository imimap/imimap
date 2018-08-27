class CreateCompanyAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :company_addresses do |t|
      t.belongs_to :company, index: true
      t.string :street
      t.string :zip
      t.string :city
      t.string :country
      t.string :phone
      t.string :fax

      t.timestamps
    end
    add_reference :internships, :company_address, foreign_key: true
  end
end

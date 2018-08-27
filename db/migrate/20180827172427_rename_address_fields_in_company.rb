class RenameAddressFieldsInCompany < ActiveRecord::Migration[5.2]
  def change
    change_table :companies do |t|
      t.rename :street, :x_street
      t.rename :zip, :x_zip
      t.rename :city, :x_city
      t.rename :country, :x_country
      t.rename :phone, :x_phone
      t.rename :fax, :x_fax
    end
  end
end

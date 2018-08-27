class RenameAddressFieldsInCompany < ActiveRecord::Migration[5.2]
  def change
    change_table :companies do |t|
      t.rename :street, :x_street
      t.rename :zip, :x_zip
      t.rename :city, :x_city
      t.rename :country, :x_country
      t.rename :phone, :x_phone
      t.rename :fax, :x_fax
      t.rename :longitude, :x_longitude
      t.rename :latitude, :x_latitude
    end
    change_table :internships do |t|
      t.rename :company_id, :x_company_id
    end
  end
end

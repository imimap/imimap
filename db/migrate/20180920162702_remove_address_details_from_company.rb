class RemoveAddressDetailsFromCompany < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :x_latitude, :float
    remove_column :companies, :x_longitude, :float
    remove_column :companies, :x_city, :string
    remove_column :companies, :x_country, :string
    remove_column :companies, :x_street, :string
    remove_column :companies, :x_zip, :string
    remove_column :companies, :x_phone, :string
    remove_column :companies, :x_fax, :string
  end
end

class RenameXInCompanies < ActiveRecord::Migration[5.2]
  def change

      change_table :companies do |t|
        t.rename :x_street, :street
        t.rename :x_zip, :zip
        t.rename :x_city, :city
        t.rename :x_country, :country
        t.rename :x_phone, :phone
        t.rename :x_fax, :fax
        t.rename :x_longitude, :longitude
        t.rename :x_latitude, :latitude
      end
      change_table :internships do |t|
        t.rename :x_company_id, :company_id
      end
    end
  end

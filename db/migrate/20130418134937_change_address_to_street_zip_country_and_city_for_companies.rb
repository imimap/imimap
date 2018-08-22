# frozen_string_literal: true

class ChangeAddressToStreetZipCountryAndCityForCompanies < ActiveRecord::Migration[4.2]
  def change
    remove_column :companies, :address
    add_column :companies, :city, :string
    add_column :companies, :country, :string
    add_column :companies, :street, :string
    add_column :companies, :zip, :integer
  end
end

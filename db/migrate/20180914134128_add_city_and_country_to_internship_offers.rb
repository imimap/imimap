class AddCityAndCountryToInternshipOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :internship_offers, :city, :string
    add_column :internship_offers, :country, :string
  end
end

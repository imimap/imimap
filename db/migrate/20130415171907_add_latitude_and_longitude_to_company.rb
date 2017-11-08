class AddLatitudeAndLongitudeToCompany < ActiveRecord::Migration[4.2]
  def change
    add_column :companies, :latitude, :float
    add_column :companies, :longitude, :float
  end
end

class AddOrientationToInternshipOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :internship_offers, :orientation, :integer
  end
end

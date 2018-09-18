class AddOrientationRefToInternshipOffers < ActiveRecord::Migration[5.2]
  def change
    add_reference :internship_offers, :orientation, foreign_key: true
  end
end

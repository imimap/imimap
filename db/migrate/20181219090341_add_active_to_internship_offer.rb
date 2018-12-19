class AddActiveToInternshipOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :internship_offers, :active, :boolean
  end
end

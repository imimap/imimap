class AddUserIdToInternshipOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :internship_offers, :user_id, :integer
  end
end

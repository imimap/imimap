class RenameOrientationInInternshipOffers < ActiveRecord::Migration[5.2]
  def change
      change_table :internship_offers do |t|
        t.rename :orientation, :orientation_id
  end
end
end

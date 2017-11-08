class AddRatingToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :rating, :integer
  end
end

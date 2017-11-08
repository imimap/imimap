class ChangeRatingToInternshipRatingIdForInternships < ActiveRecord::Migration[4.2]
  def change
    rename_column :internships, :rating, :internship_rating_id  
  end
end

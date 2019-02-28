class AddCompleteInternshipToInternships < ActiveRecord::Migration[5.2]
  def change
    add_reference :internships, :complete_internship, foreign_key: true
  end
end

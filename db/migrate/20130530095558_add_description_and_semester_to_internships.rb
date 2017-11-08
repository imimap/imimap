class AddDescriptionAndSemesterToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :description, :text
    add_column :internships, :semester, :string
  end
end

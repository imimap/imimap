class AddSemesterIdToInternship < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :semester_id, :integer
  end
end

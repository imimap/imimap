class RenameSalaryToSalaryIdForInternships < ActiveRecord::Migration[4.2]
    def change
      rename_column :internships, :salary, :salary_id
      change_column :internships, :salary_id, :integer
    end
end

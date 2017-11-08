class ChangeSalaryIdToSalaryOnInternship < ActiveRecord::Migration[4.2]
  def change
    remove_column :internships, :salary_id
    add_column :internships, :salary, :integer
  end
end

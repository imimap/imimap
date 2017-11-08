class AddStartDateAndEndDateToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :start_date, :date
    add_column :internships, :end_date, :date
  end
end

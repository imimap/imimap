class RemoveDepartmentFromCompanies < ActiveRecord::Migration[4.2]
  def change
    remove_column :companies, :department
  end
end

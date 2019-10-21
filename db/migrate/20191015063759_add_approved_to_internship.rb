class AddApprovedToInternship < ActiveRecord::Migration[6.0]
  def change
    add_column :internships, :approved, :boolean, default: true
  end
end

class AddCompletedToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :completed, :boolean, :default => false
  end
end

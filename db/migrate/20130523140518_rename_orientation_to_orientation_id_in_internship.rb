class RenameOrientationToOrientationIdInInternship < ActiveRecord::Migration[4.2]
  def change
      remove_column :internships, :orientation
      add_column :internships, :orientation_id, :integer
    end
end

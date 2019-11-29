class RemoveInternshipTitleFromInternships < ActiveRecord::Migration[6.0]
  def change
    remove_column :internships, :title, :string
  end
end

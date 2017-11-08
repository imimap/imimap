class AddInternshipToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :internship_id, :integer  
  end
end

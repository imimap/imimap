class AddUserIdToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :user_id, :integer
  end
end

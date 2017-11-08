class AddUserToAnswer < ActiveRecord::Migration[4.2]
  def change
    add_column :answers, :user_id, :integer
  end
end

class RemovePassDigest < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :password_digest, :old_pass_digesr
  end
end

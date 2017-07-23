class RemovePassDigest < ActiveRecord::Migration
  def change
    rename_column :users, :password_digest, :old_pass_digesr
  end
end

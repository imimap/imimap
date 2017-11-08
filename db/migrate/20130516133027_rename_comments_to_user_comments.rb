class RenameCommentsToUserComments < ActiveRecord::Migration[4.2]
  def change
    rename_table :comments, :user_comments
  end
end

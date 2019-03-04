class DeleteUserComments < ActiveRecord::Migration[5.2]
  def up
    drop_table :answers
    drop_table :user_comments
  end
  def
    create_table :answers
    create_table :user_comments
  end
end

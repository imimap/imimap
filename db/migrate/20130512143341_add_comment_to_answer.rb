class AddCommentToAnswer < ActiveRecord::Migration[4.2]
  def change
    add_column :answers, :comment_id, :integer  
  end
end

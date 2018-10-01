class AddCommentToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :comment, :text
  end
end

class ChangeInternshipCommentToText < ActiveRecord::Migration[5.2]
  def up
    change_column :internships, :comment, :text
  end
  def down
    change_column :internships, :comment, :string
  end
end

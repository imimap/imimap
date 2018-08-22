# frozen_string_literal: true

class RenameCommentIdToUserCommentId < ActiveRecord::Migration[4.2]
  def change
    rename_column :answers, :comment_id, :user_comment_id
  end
end

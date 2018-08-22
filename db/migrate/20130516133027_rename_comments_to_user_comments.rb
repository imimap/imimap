# frozen_string_literal: true

class RenameCommentsToUserComments < ActiveRecord::Migration[4.2]
  def change
    rename_table :comments, :user_comments
  end
end

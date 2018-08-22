# frozen_string_literal: true

class RemovePostAndCommenterFromComments < ActiveRecord::Migration[4.2]
  def change
    remove_column :comments, :commenter
    remove_column :comments, :post_id
  end
end

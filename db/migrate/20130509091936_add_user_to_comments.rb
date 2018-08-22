# frozen_string_literal: true

class AddUserToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :user_id, :integer
  end
end

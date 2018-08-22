# frozen_string_literal: true

class RemoveUnusedAttributesFromUser < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :major
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :role
    remove_column :users, :picture
  end
end

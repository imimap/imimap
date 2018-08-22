# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text :text
      t.boolean :read

      t.timestamps
    end
  end
end

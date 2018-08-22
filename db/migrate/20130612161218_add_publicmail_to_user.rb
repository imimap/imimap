# frozen_string_literal: true

class AddPublicmailToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :publicmail, :boolean
  end
end

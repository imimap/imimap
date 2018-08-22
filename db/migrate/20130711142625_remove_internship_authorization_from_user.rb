# frozen_string_literal: true

class RemoveInternshipAuthorizationFromUser < ActiveRecord::Migration[4.2]
  def up
    remove_column :users, :internship_authorization
  end

  def down
    add_column :users, :internship_authorization, :boolean
  end
end

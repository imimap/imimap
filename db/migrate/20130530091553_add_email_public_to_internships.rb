# frozen_string_literal: true

class AddEmailPublicToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :email_public, :boolean
  end
end

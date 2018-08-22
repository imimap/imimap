# frozen_string_literal: true

class AddTitleToInternship < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :title, :string
  end
end

# frozen_string_literal: true

class AddTasksAndOperationalAreaToInternship < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :tasks, :text
    add_column :internships, :operational_area, :string
  end
end

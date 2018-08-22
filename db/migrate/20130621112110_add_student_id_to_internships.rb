# frozen_string_literal: true

class AddStudentIdToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :student_id, :integer
  end
end

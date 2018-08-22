# frozen_string_literal: true

class AddStudentIdToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :student_id, :string
  end
end

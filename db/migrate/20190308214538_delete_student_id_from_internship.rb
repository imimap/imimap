# frozen_string_literal: true

class DeleteStudentIdFromInternship < ActiveRecord::Migration[5.2]
  def change
    # the remove_reference was only recognized by sqlite,
    # didn't work on postgres
    # remove_reference :internships, :student,foreign_key: true

    remove_column :internships, :student_id
  end
end

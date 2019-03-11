class DeleteStudentIdFromInternship < ActiveRecord::Migration[5.2]
  def change
    remove_reference :internships, :student,foreign_key: true
end

#  end
#  def down
#    add_reference :internships, :student, :
end
#add_reference :internships, :complete_internship, foreign_key: true

class ChangeMatrikelNrToEnrolmentNumberForStudents < ActiveRecord::Migration[4.2]
  def change
    rename_column :students, :matrikelNr, :enrolment_number
  end  
end
